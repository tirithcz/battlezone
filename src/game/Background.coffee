# Background consisting of horizon and (TODO) mountains and a volcano.
# TODO: clipping problems, perhaps horizon should be more fake than a distant circle.
class BackgroundModel extends Model
  constructor: ->
    super
    
    @color = Renderer.GREEN
    @renderMode = "lines"
    
    r = 1000
    o = 0 #r/2
    c = 0
    for a in [0...2*Math.PI] by 0.1
      @addVertex new Vector3(r*Math.cos(a) - o, 0, r*Math.sin(a) - o)
      if (c>0) then @indices.push c
      @indices.push c++
    
    @indices.pop()
    # TODO: fix complete indices

