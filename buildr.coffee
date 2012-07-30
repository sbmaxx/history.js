# Requires
buildr = require 'buildr'
util = require 'util'

# Options
options =
	watch: false
	compress: false

# Configs
configs =
	standard:
		# Options
		name: 'standard'
		watch: options.watch

		# Paths
		srcPath: __dirname+'/scripts/uncompressed'
		outPath: __dirname+'/scripts/compressed'

		# Checking
		checkScripts: true
		jshintOptions:
			browser: true
			laxbreak: true
			boss: true
			undef: true
			onevar: true
			strict: true
			noarg: true

		# Compression (without outPath only the generated bundle files are compressed)
		compressScripts: options.compress # Array or true or false

	other: [

		# -----------------------------
		# BEM HTML5

		{
			# Options
			name: 'bem'
			watch: options.watch

			# Paths
			srcPath: __dirname+'/scripts/uncompressed'

			# Compression (without outPath only the generated bundle files are compressed)
			compressScripts: options.compress # Array or true or false

			# Order
			scriptsOrder: [
				'history.adapter.jquery.js'
				'history.js'
			]

			# Bundling
			bundleScriptPath: __dirname+'/scripts/bundled/bem/i-jquery__history.js'
		},

        # BEM HTML4
		{
			# Options
			name: 'bem-html4'
			watch: options.watch

			# Paths
			srcPath: __dirname+'/scripts/uncompressed'

			# Compression (without outPath only the generated bundle files are compressed)
			compressScripts: options.compress # Array or true or false

			# Order
			scriptsOrder: [
                'history.html4.js'
			]

			# Bundling
			bundleScriptPath: __dirname+'/scripts/bundled/bem/i-jquery__history_html4_yes.js'
		}

	]

# Standard
standardConfig = configs.standard
standardConfig.successHandler = ->
	for config in configs.other
		buildrInstance = buildr.createInstance config
		buildrInstance.process()

# Process
standardBuildr = buildr.createInstance configs.standard
standardBuildr.process()
