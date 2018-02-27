log = (msg) ->
    console.log "clickandscroll: " + msg

log "up and running"

# helper functions
pageHeight = ->
    document.documentElement.scrollHeight

pageWidth = ->
    document.documentElement.scrollWidth

viewHeight = ->
    Math.max document.documentElement.clientHeight, window.innerHeight or 0

viewWidth = ->
    Math.max document.documentElement.clientWidth, window.innerWidth or 0

# mouse button constants
mouseLeft = 0
mouseMiddle = 1
mouseRight = 2

# preferences
# enable vertical scrolling
vertical = true
# enable horizontal scrolling
horizontal = true
# maximum time in milliseconds between two successive clicks for a double click 
dblclick_threshold = 200
scrollTrigger = mouseRight

# global variables
multiplicatorX = multiplicatorY = 1
initX = initY = 0
scrollLock = false
lastTime = 0
contextLock = true if scrollTrigger is mouseRight

onmouseup = (e) ->
    if e.button isnt scrollTrigger
        return

    scrollLock = false
    document.removeEventListener "mousemove", onmousemove
    return

onmousemove = (e) ->
    unless vertical
        initY = e.pageY
    unless horizontal
        initX = e.pageX

    window.scrollBy (e.pageX - initX) * multiplicatorX,
                    (e.pageY - initY) * multiplicatorY
    initY = e.pageY
    initX = e.pageX
    return

onmousedown = (e) ->
    if e.button isnt scrollTrigger
        return

    if Date.now() - lastTime >= dblclick_threshold
        # it's the first click
        e.preventDefault()
        if e.type is "contextmenu" or scrollTrigger isnt mouseRight
            lastTime = Date.now()
    else
        contextLock = false
        return

    unless scrollLock
        scrollLock = true

        initX = e.pageX
        initY = e.pageY

        # log "mouse position on page: " + initX + "x" + initY

        vWidth = viewWidth()
        vHeight = viewHeight()
        pWidth = pageWidth()
        pHeight = pageHeight()

        # log "viewport: " + vWidth + "x" + vHeight
        # log "page: " + pWidth + "x" + pHeight

        multiplicatorX = pWidth / vWidth
        multiplicatorY = pHeight / vHeight

        # log "multiplicatorX: " + multiplicatorX
        # log "multiplicatorY: " + multiplicatorY

        document.addEventListener "mousemove", onmousemove
    return

document.addEventListener "mousedown", onmousedown
document.addEventListener "contextmenu", onmousedown
document.addEventListener "mouseup", onmouseup
