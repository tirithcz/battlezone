class Renderer
  @RED = 'rgba(255,0,0,0.5)'
  @GREEN = 'rgba(0,255,0,0.5)'
  @BLUE = '#00F'
  @WHITE = '#FFF'
  @BLACK = '#000'

  constructor: ->
    @canvas = $('#canvas')
    @context = @canvas.get(0).getContext '2d'
    @context.font = '400 16px/2 Unknown Font, sans-serif'    
    @context.lineWidth = 1;
    @context.lineCap = "butt"    
        
    projection = new Projection(@canvas.width(), @canvas.height(), 0.1, 1000, 80.0);
    viewMatrix = new Matrix4()
    viewMatrix.translate(0, -4, -10)
    
    width = @canvas.width()
    height = @canvas.height()
    
    halfWidth = width / 2
    halfHeight = height / 2
    
    viewportMatrix = new Matrix3()
    viewportMatrix.set( 
      halfWidth, 0,  0
      0, -halfHeight, 0,
      halfWidth, halfHeight, 1
    )
    
    @pipeline = new Pipeline()
    @pipeline.setProjection projection.getMatrix()
    @pipeline.setView viewMatrix
    @pipeline.setViewport viewportMatrix
    
  clear: ->
    @context.clearRect(0,0, @canvas.width(), @canvas.height())  
    
  drawPixel: (x, y, color) ->
    @context.save()
    @context.fillStyle = color
    @context.fillRect(x-1,y-1,3,3)  
    @context.restore()
  
  drawText: (x, y, string, color) ->
    @context.save()
    if not color? then color = Renderer.WHITE
    @context.fillStyle = color
    @context.fillText string, x, y
    @context.restore()
    
  drawLine: (fromX, fromY, toX, toY, color) ->
    @context.save();
    @context.beginPath()
    @context.strokeStyle = color
    @context.moveTo fromX, fromY
    @context.lineTo toX, toY
    @context.stroke()
    @context.restore();

