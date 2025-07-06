export class Utils {

	navbarScrollLeft(navBar) {
		document.querySelector(navBar).setAttribute("data-position", -1);
		this.navbarScrollRight(navBar);
	}

	navbarScrollRight(navBar) {
		let position = new Number(
			document.querySelector(navBar).getAttribute("data-position")
		);
		position++;
		let filler = document.querySelector(navBar);
		filler.style.left = -(position * 100) + "px";
		document.querySelector(navBar).setAttribute("data-position", position);
	}

	formatDateTime(dateVal) {
		let dateObj = new Date(dateVal);
		return dateObj.toLocaleString("pt-BR").replace(",", "");
	}

	uuidv4() {
		let uuid;
		do {
			uuid = crypto.randomUUID();
		} while (/^\d/.test(uuid)); // Repete se começar com número
		return uuid;
	}

	dragElement(el) {
		var pos1 = 0,
			pos2 = 0,
			pos3 = 0,
			pos4 = 0;
		if (document.querySelector(`div#${el.id} div.card-header`)) {
			/* if present, the header is where you move the DIV from:*/
			document.querySelector(`div#${el.id} div.card-header`).onmousedown =
				dragMouseDown;
		} else {
			/* otherwise, move the DIV from anywhere inside the DIV:*/
			el.onmousedown = dragMouseDown;
		}

		function dragMouseDown(e) {
			e = e || window.event;
			e.preventDefault();
			// get the mouse cursor position at startup:
			pos3 = e.clientX;
			pos4 = e.clientY;
			document.onmouseup = closeDragElement;
			// call a function whenever the cursor moves:
			document.onmousemove = elementDrag;
		}

		function elementDrag(e) {
			e = e || window.event;
			e.preventDefault();
			// calculate the new cursor position:
			pos1 = pos3 - e.clientX;
			pos2 = pos4 - e.clientY;
			pos3 = e.clientX;
			pos4 = e.clientY;
			// set the element's new position:
			el.style.top = el.offsetTop - pos2 + "px";
			el.style.left = el.offsetLeft - pos1 + "px";
		}

		function closeDragElement() {
			/* stop moving when mouse button is released:*/
			document.onmouseup = null;
			document.onmousemove = null;
		}
	}

	jsonPath(obj, expr, arg) {
		var P = {
			resultType: arg && arg.resultType || "VALUE",
			result: [],
			normalize: function (expr) {
				var subx = [];
				return expr.replace(/[\['](\??\(.*?\))[\]']/g, function ($0, $1) { return "[#" + (subx.push($1) - 1) + "]"; })
					.replace(/'?\.'?|\['?/g, ";")
					.replace(/;;;|;;/g, ";..;")
					.replace(/;$|'?\]|'$/g, "")
					.replace(/#([0-9]+)/g, function ($0, $1) { return subx[$1]; });
			},
			asPath: function (path) {
				var x = path.split(";"), p = "$";
				for (var i = 1, n = x.length; i < n; i++)
					p += /^[0-9*]+$/.test(x[i]) ? ("[" + x[i] + "]") : ("['" + x[i] + "']");
				return p;
			},
			store: function (p, v) {
				if (p) P.result[P.result.length] = P.resultType == "PATH" ? P.asPath(p) : v;
				return !!p;
			},
			trace: function (expr, val, path) {
				if (expr) {
					var x = expr.split(";"), loc = x.shift();
					x = x.join(";");
					if (val && val.hasOwnProperty(loc))
						P.trace(x, val[loc], path + ";" + loc);
					else if (loc === "*")
						P.walk(loc, x, val, path, function (m, l, x, v, p) { P.trace(m + ";" + x, v, p); });
					else if (loc === "..") {
						P.trace(x, val, path);
						P.walk(loc, x, val, path, function (m, l, x, v, p) { typeof v[m] === "object" && P.trace("..;" + x, v[m], p + ";" + m); });
					}
					else if (/,/.test(loc)) { // [name1,name2,...]
						for (var s = loc.split(/'?,'?/), i = 0, n = s.length; i < n; i++)
							P.trace(s[i] + ";" + x, val, path);
					}
					else if (/^\(.*?\)$/.test(loc)) // [(expr)]
						P.trace(P.eval(loc, val, path.substr(path.lastIndexOf(";") + 1)) + ";" + x, val, path);
					else if (/^\?\(.*?\)$/.test(loc)) // [?(expr)]
						P.walk(loc, x, val, path, function (m, l, x, v, p) { if (P.eval(l.replace(/^\?\((.*?)\)$/, "$1"), v[m], m)) P.trace(m + ";" + x, v, p); });
					else if (/^(-?[0-9]*):(-?[0-9]*):?([0-9]*)$/.test(loc)) // [start:end:step]  phyton slice syntax
						P.slice(loc, x, val, path);
				}
				else
					P.store(path, val);
			},
			walk: function (loc, expr, val, path, f) {
				if (val instanceof Array) {
					for (var i = 0, n = val.length; i < n; i++)
						if (i in val)
							f(i, loc, expr, val, path);
				}
				else if (typeof val === "object") {
					for (var m in val)
						if (val.hasOwnProperty(m))
							f(m, loc, expr, val, path);
				}
			},
			slice: function (loc, expr, val, path) {
				if (val instanceof Array) {
					var len = val.length, start = 0, end = len, step = 1;
					loc.replace(/^(-?[0-9]*):(-?[0-9]*):?(-?[0-9]*)$/g, function ($0, $1, $2, $3) { start = parseInt($1 || start); end = parseInt($2 || end); step = parseInt($3 || step); });
					start = (start < 0) ? Math.max(0, start + len) : Math.min(len, start);
					end = (end < 0) ? Math.max(0, end + len) : Math.min(len, end);
					for (var i = start; i < end; i += step)
						P.trace(i + ";" + expr, val, path);
				}
			},
			eval: function (x, _v, _vname) {
				try { return $ && _v && eval(x.replace(/@/g, "_v")); }
				catch (e) { throw new SyntaxError("jsonPath: " + e.message + ": " + x.replace(/@/g, "_v").replace(/\^/g, "_a")); }
			}
		};

		var $ = obj;
		if (expr && obj && (P.resultType == "VALUE" || P.resultType == "PATH")) {
			P.trace(P.normalize(expr).replace(/^\$;/, ""), obj, "$");
			return P.result.length ? P.result : false;
		}
	}

}
