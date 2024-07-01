function varargout = plotframe( rotationMatrix, translationVector, ...
        basisVectorLengths, Options, QuiverProperties )
%PLOTFRAME Plot a 3-D Cartesian coordinate system.
%     plotframe( )
%     plotframe( rotationMatrix, translationVector )
%     plotframe( rotationMatrix, translationVector, basisVectorLengths )
%     plotframe( __ , Parent=ax )
%     plotframe( __ , Name=Value )
%     hg = plotframe( __ )
% 
%   INPUTS
%   - rotationMatrix        Defines the orientation of the coordinate  
%                           frame, from the origin. 3-by-3 orthogonal 
%                           matrix. Default is zero rotation, i.e., eye(3). 
%   - translationVector     Defines the position of coordinate frame, from 
%                           the origin. 1-by-3 or 3-by-1 numeric vector.
%                           Default is [0 0 0].
%   - basisVectorLengths    Length to plot each arrow (basis) of the
%                           coordinate frame. Scalar, 1-by-3, or 3-by-1 
%                           numeric vector. Default is 1.
%   - Name-Value Arguments
%       + Parent            Axes in which to plot. Scalar axes, group 
%                           (hggroup), or transform (hgtransform) object.
%                           Default is the current axes (gca).
%       + UpdateFrame       With UpdateFrame, the passed plot handles
%                           will be updated with the current parameters, 
%                           rather than creating a new plot. This is more 
%                           efficient and convenient for moving frames.
%                           Handle to an existing frame plot, outputted
%                           from a previous call to plotframe.
%       + MatrixIndexing    Depending on notation, either the columns or 
%                           the rows of rotationMatrix define the 
%                           orientation of the basis vectors. Text scalar, 
%                           either "columnmajor" or "rowmajor". Default is 
%                           row-major.
%       + LabelBasis        Whether the bases should be labelled, e.g., 
%                           "X", "Y", and "Z". Scalar logical. Default is 
%                           false.
%       + Labels            Text with which to label each basis, if 
%                           LabelBasis is enabled. Scalar, 1-by-3, or 
%                           3-by-1 text vector. Default is {'X','Y','Z'}.
%       + BasisColors       Color for each basis vector. Any color format
%                           accepted by MATLAB can be used, e.g., RGB 
%                           triplet [0 0 0], hexadecimal color code 
%                           #000000, or color name 'black' or 'k'. Specify
%                           multiple colors with an M-by-3 matrix where 
%                           each RGB color is a row, or as a 1-by-3 or 
%                           3-by-1 text array. Default is {'r','g','b'}.
%       + TextProperties    Custom properties for the basis labels. 
%                           Name-value arguments stored in a cell array of 
%                           alternating text property names and values, 
%                           e.g., {'FontSize',20,'FontWeight','bold'}.
%       + QuiverProperties  Additional name-value arguments are passed as
%                           properties of the Quiver charts used to plot 
%                           the basis vectors, e.g.,
%                           plotframe( LineStyle="-.", Marker="o" ).
%   OUTPUTS
%   - hg                    Group object (hggroup) containing handles to  
%                           the constituent parts of the coordinate frame 
%                           plot, i.e., the 3 Quiver and optional Text 
%                           objects.
% 
%   EXAMPLES: Please see the file 'examples.mlx' or 'examples.pdf'.
%    
%   Created in 2022b. Compatible with 2020b and later. Compatible with all 
%   platforms. Please cite George Abrahams 
%   https://github.com/WD40andTape/plotframe.
% 
%   See also QUIVER3, QUAT2ROTM, EUL2ROTM, MAKEHGTFORM, PLOTCAMERA

%   Published under MIT License (see LICENSE.txt).
%   Copyright (c) 2023 George Abrahams.
%   - https://github.com/WD40andTape/
%   - https://www.linkedin.com/in/georgeabrahams/

    arguments
        rotationMatrix (3,3) double { mustBeNonNan, mustBeFloat, ...
            mustBeOrthonormal } = eye( 3 )
        translationVector (1,3) double = [ 0, 0, 0 ]
        basisVectorLengths (3,1) double = 1
        Options.MatrixIndexing { mustBeTextScalar, mustBeMember( ...
            Options.MatrixIndexing, [ "columnmajor", "rowmajor"] ) } ...
            = "rowmajor"
        Options.Parent (1,1) { mustBeAxes } = gca
        Options.UpdateFrame matlab.graphics.primitive.Group ...
            { mustBeFrameHG } = matlab.graphics.primitive.Group.empty
        Options.LabelBasis (1,1) logical = false
        Options.Labels (3,1) { mustBeText } = { 'X'; 'Y'; 'Z' }
        Options.BasisColors { mustBeValidColors } = { 'r'; 'g'; 'b' }
        Options.TextProperties cell = {}
        QuiverProperties.?matlab.graphics.chart.primitive.Quiver
        QuiverProperties.AutoScale (1,1) matlab.lang.OnOffSwitchState ...
            { mustBeMember( QuiverProperties.AutoScale, 'off' ) } = 'off'
    end

    isUpdateFrame = ~isempty( Options.UpdateFrame );
    if ~isUpdateFrame
        hg = hggroup( Options.Parent );
    else
        hg = Options.UpdateFrame;
        hg.Parent = Options.Parent;
    end
    [ hQuiver, hText ] = parsehandles( Options.UpdateFrame );
    initgobjects = @( fun ) arrayfun( @(~) fun( 'Parent', hg ), 1:3 );
    
    % If row-major order, the rows of the matrix denote its basis vectors.
    % If column-major order, the columns are its basis vectors.
    if any( isnan( translationVector ) )
        translationVector = [ 0, 0, 0 ];
    end
    if any( isnan( basisVectorLengths ) )
        basisVectorLengths = 1;
    end
    if strncmpi( Options.MatrixIndexing, "columnmajor", 1 )
        rotationMatrix = rotationMatrix';
        Options.MatrixIndexing = "rowmajor";
    end
    basisVectors = rotationMatrix .* basisVectorLengths;
    rgb = validatecolor( Options.BasisColors, 'multiple' );
    quiverProps = namedargs2cell( QuiverProperties );
    if isempty( hQuiver )
        hQuiver = initgobjects( @matlab.graphics.chart.primitive.Quiver );
    end
    set( hQuiver, 'LineWidth', 2, 'MaxHeadSize', 0.4 )
    set( hQuiver, quiverProps{:} )
    set( hQuiver, ...
        { 'XData', 'YData', 'ZData' }, num2cell( translationVector ), ...
        { 'UData', 'VData', 'WData' }, num2cell( basisVectors ), ...
        { 'Color'                   }, num2cell( rgb, 2 ) )
    
    if Options.LabelBasis
        if ~isfield( QuiverProperties, 'Alignment' ) || ...
                strcmpi( QuiverProperties.Alignment, 'tail' )
            textPosition = translationVector + basisVectors;
        elseif strcmpi( QuiverProperties.Alignment, 'center' )
            textPosition = translationVector + basisVectors / 2;
        else % QuiverProperties.Alignment = 'head'
            textPosition = translationVector - basisVectors;
        end
        if isempty( hText )
            hText = initgobjects( @matlab.graphics.primitive.Text );
        end
        set( hText, { 'Position' }, num2cell( textPosition, 2 ), ...
                    { 'String'   }, cellstr( Options.Labels ) )
        if ~isempty( Options.TextProperties )
            try
                set( hText, Options.TextProperties{:} );
            catch ME
                id = "plotframe:InvalidTextProperties";
                msg = "One or more properties or values in the " + ...
                    "TextProperties name-value argument are not valid.";
                ME = addCause( ME, MException( id, msg ) );
                throw( ME )
            end
        end
    elseif ~isempty( hText )
        delete( hText )
    end

    if isUpdateFrame
        drawnow
    end

    if nargout > 0
        varargout = { hg };
    end

end

%% Utility functions

function [ hQuiver, hText ] = parsehandles( hg )
    handlesofclass = @(x) findobj( hg, '-isa', x );
    hQuiver = handlesofclass( 'matlab.graphics.chart.primitive.Quiver' );
    hText = handlesofclass( 'matlab.graphics.primitive.Text' );
end

%% Validation functions

function mustBeOrthonormal( matrix )
    tolerance = 1e-4;
    mxmT = pagemtimes( matrix, "none", matrix, "transpose" );
    eyeDiff = abs( mxmT - eye( 3 ) );
    isOrthonormal = squeeze( all( eyeDiff < tolerance, [1 2] ) );
    if ~isOrthonormal
        id = "plotframe:Validators:MatrixNotOrthonormal";
        msg = sprintf( ...
            "Must be orthonormal (within tolerance %s), i.e., " + ...
            "the basis vectors must be perpendicular and unit length.", ...
            string( tolerance ) );
        throwAsCaller( MException( id, msg ) )
    end
end

function mustBeAxes( x )
    % Validate that x is a valid graphics objects parent, i.e., an axes, 
    % group (hggroup), or transform (hgtransform) object, and has not been 
    % deleted (closed, cleared, etc).
    isAxes = isgraphics( x, "axes" ) || isgraphics( x, "hggroup" ) || ...
         isgraphics( x, "hgtransform" );
    if ~isAxes
        id = "plotframe:Validators:InvalidAxesHandle";
        msg = "Must be handle to graphics objects " + ...
            "parents which have not been deleted.";
        throwAsCaller( MException( id, msg ) )
    end
end

function mustBeFrameHG( hg )
    [ hQuiver, hText ] = parsehandles( hg );
    isFrame = numel( hQuiver ) == 3 && ...
        ( numel( hText ) == 0 || numel( hText ) == 3 );
    if ~isFrame && ~isempty( hg )
        id = "plotframe:Validators:CantUpdateFrame";
        msg = "Must be either an empty Group object or a Group " + ...
            "object returned by a previous call to the function.";
        throwAsCaller( MException( id, msg ) )
    end
end

function mustBeValidColors( colors )
    % validatecolors will either throw an error, which will be handled by
    % the PLOTFRAME arguments block, or return the equivalent RGB colors.
    rgb = validatecolor( colors, 'multiple' );
    nColors = size( rgb, 1 );
    if nColors ~= 1 && nColors ~= 3
        id = "plotframe:Validators:WrongNumberOfColors";
        msg = "Must contain either 1 color (for all 3 axes) or 3 " + ...
            "colors (one for each of the 3 axes).";
        throwAsCaller( MException( id, msg ) )
    end
end