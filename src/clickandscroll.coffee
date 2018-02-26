log = (msg) ->
    console.log "clickandscroll: " + msg

# preferences
# enable vertical scrolling
vertical = true
# enable horizontal scrolling
horizontal = true
# maximum time in milliseconds between two successive clicks for a double click 
dblclick_threshold = 200

# global variables
multiplicatorX = multiplicatorY = 1
initX = initY = 0
scrollLock = false
lastTime = 0

# helper functions
pageHeight = ->
    document.documentElement.scrollHeight

pageWidth = ->
    document.documentElement.scrollWidth

viewHeight = ->
    Math.max document.documentElement.clientHeight, window.innerHeight or 0

viewWidth = ->
    Math.max document.documentElement.clientWidth, window.innerWidth or 0

# eventhandler for mousemove
scroll = (e) ->
    unless vertical
        initY = e.pageY
    unless horizontal
        initX = e.pageX

    window.scrollBy (e.pageX - initX) * multiplicatorX,
                    (e.pageY - initY) * multiplicatorY
    initY = e.pageY
    initX = e.pageX
    return

document.addEventListener "contextmenu", (e) ->
    console.log e.type
    log "lastTime: " + lastTime
    if Date.now() - lastTime >= dblclick_threshold
        # it's the first click
        e.preventDefault()
        lastTime = Date.now()
    else
        # it's the second click
        return

    unless scrollLock
        scrollLock = true

        initX = e.pageX
        initY = e.pageY

        log "mouse position on page: " + initX + "x" + initY

        vWidth = viewWidth()
        vHeight = viewHeight()
        pWidth = pageWidth()
        pHeight = pageHeight()

        log "viewport: " + vWidth + "x" + vHeight
        log "page: " + pWidth + "x" + pHeight

        multiplicatorX = pWidth / vWidth
        multiplicatorY = pHeight / vHeight

        log "multiplicatorX: " + multiplicatorX
        log "multiplicatorY: " + multiplicatorY

        document.addEventListener "mousemove", scroll
    return

document.addEventListener "mouseup", (e) ->
    console.log e.type
    if e.button isnt 2 then return
    scrollLock = false
    document.removeEventListener "mousemove", scroll
    return
