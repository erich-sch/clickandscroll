log = (msg) ->
    console.log "clickandscroll: " + msg

# preferences
vertical = true
horizontal = true
multiplicatorY = 1
multiplicatorX = 1

initX = initY = 0
scrollLock = false

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
    e.preventDefault()
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
