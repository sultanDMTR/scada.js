require! 'through2': through
require! "child_process": {spawn}
require! 'path'

module.exports = (file) ->
    through (buf, enc, next) ->
        # skip if this is not a dart file
        return next! unless path.extname file is \.dart

        /*
        # process otherwise
        content = buf.to-string \utf8
        child = spawn "/usr/lib/dart/bin/dart2js", null
        this.push(optimize-js content)
        next!
        */
