define [], ->

	(ns, nsSplitter = '.') ->
		ns = ns.split nsSplitter
		o = window
		o = o[i] = o[i] or {} for i in ns
			