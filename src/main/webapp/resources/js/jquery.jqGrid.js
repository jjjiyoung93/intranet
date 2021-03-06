/*
 jqGrid  4.6.0 - jQuery Grid
 Copyright (c) 2008, Tony Tomov, tony@trirand.com
 Dual licensed under the MIT and GPL licenses
 http://www.opensource.org/licenses/mit-license.php
 http://www.gnu.org/licenses/gpl-2.0.html
 Date: 2014-02-20
*/
(function(a) {
    a.jgrid = a.jgrid || {};
    a.extend(a.jgrid, {
        version: "4.6.0",
        htmlDecode: function(a) {
            return a && ("&nbsp;" === a || "&#160;" === a || 1 === a.length && 160 === a.charCodeAt(0)) ? "" : !a ? a : ("" + a).replace(/&gt;/g, ">").replace(/&lt;/g, "<").replace(/&quot;/g, '"').replace(/&amp;/g, "&")
        },
        htmlEncode: function(a) {
            return !a ? a : ("" + a).replace(/&/g, "&amp;").replace(/\"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
        },
        format: function(d) {
            var e = a.makeArray(arguments).slice(1);
            null == d && (d = "");
            return d.replace(/\{(\d+)\}/g,
                function(a, d) {
                    return e[d]
                })
        },
        msie: "Microsoft Internet Explorer" === navigator.appName,
        msiever: function() {
            var a = -1;
            null != /MSIE ([0-9]{1,}[.0-9]{0,})/.exec(navigator.userAgent) && (a = parseFloat(RegExp.$1));
            return a
        },
        getCellIndex: function(d) {
            d = a(d);
            if (d.is("tr")) return -1;
            d = (!d.is("td") && !d.is("th") ? d.closest("td,th") : d)[0];
            return a.jgrid.msie ? a.inArray(d, d.parentNode.cells) : d.cellIndex
        },
        stripHtml: function(a) {
            var a = "" + a,
                e = /<("[^"]*"|'[^']*'|[^'">])*>/gi;
            return a ? (a = a.replace(e, "")) && "&nbsp;" !== a && "&#160;" !==
                a ? a.replace(/\"/g, "'") : "" : a
        },
        stripPref: function(d, e) {
            var b = a.type(d);
            if ("string" === b || "number" === b) d = "" + d, e = "" !== d ? ("" + e).replace("" + d, "") : e;
            return e
        },
        parse: function(d) {
            "while(1);" === d.substr(0, 9) && (d = d.substr(9));
            "/*" === d.substr(0, 2) && (d = d.substr(2, d.length - 4));
            d || (d = "{}");
            return !0 === a.jgrid.useJSON && "object" === typeof JSON && "function" === typeof JSON.parse ? JSON.parse(d) : eval("(" + d + ")")
        },
        parseDate: function(d, e, b, f) {
            var c = /^\/Date\((([-+])?[0-9]+)(([-+])([0-9]{2})([0-9]{2}))?\)\/$/,
                h = "string" === typeof e ?
                e.match(c) : null,
                c = function(a, c) {
                    a = "" + a;
                    for (c = parseInt(c, 10) || 2; a.length < c;) a = "0" + a;
                    return a
                },
                g = {
                    m: 1,
                    d: 1,
                    y: 1970,
                    h: 0,
                    i: 0,
                    s: 0,
                    u: 0
                },
                i = 0,
                j, k, i = function(a, c) {
                    0 === a ? 12 === c && (c = 0) : 12 !== c && (c += 12);
                    return c
                };
            void 0 === f && (f = a.jgrid.formatter.date);
            void 0 === f.parseRe && (f.parseRe = /[#%\\\/:_;.,\t\s-]/);
            f.masks.hasOwnProperty(d) && (d = f.masks[d]);
            if (e && null != e)
                if (!isNaN(e - 0) && "u" === ("" + d).toLowerCase()) i = new Date(1E3 * parseFloat(e));
                else if (e.constructor === Date) i = e;
            else if (null !== h) {
                if (i = new Date(parseInt(h[1], 10)),
                    h[3]) {
                    var m = 60 * Number(h[5]) + Number(h[6]),
                        m = m * ("-" === h[4] ? 1 : -1),
                        m = m - i.getTimezoneOffset();
                    i.setTime(Number(Number(i) + 6E4 * m))
                }
            } else {
                m = 0;
                "ISO8601Long" === f.srcformat && "Z" === e.charAt(e.length - 1) && (m -= (new Date).getTimezoneOffset());
                e = ("" + e).replace(/\T/g, "#").replace(/\t/, "%").split(f.parseRe);
                d = d.replace(/\T/g, "#").replace(/\t/, "%").split(f.parseRe);
                j = 0;
                for (k = d.length; j < k; j++) "M" === d[j] && (h = a.inArray(e[j], f.monthNames), -1 !== h && 12 > h && (e[j] = h + 1, g.m = e[j])), "F" === d[j] && (h = a.inArray(e[j], f.monthNames, 12), -1 !== h && 11 < h && (e[j] = h + 1 - 12, g.m = e[j])), "a" === d[j] && (h = a.inArray(e[j], f.AmPm), -1 !== h && (2 > h && e[j] === f.AmPm[h]) && (e[j] = h, g.h = i(e[j], g.h))), "A" === d[j] && (h = a.inArray(e[j], f.AmPm), -1 !== h && (1 < h && e[j] === f.AmPm[h]) && (e[j] = h - 2, g.h = i(e[j], g.h))), "g" === d[j] && (g.h = parseInt(e[j], 10)), void 0 !== e[j] && (g[d[j].toLowerCase()] = parseInt(e[j], 10));
                g.f && (g.m = g.f);
                if (0 === g.m && 0 === g.y && 0 === g.d) return "&#160;";
                g.m = parseInt(g.m, 10) - 1;
                i = g.y;
                70 <= i && 99 >= i ? g.y = 1900 + g.y : 0 <= i && 69 >= i && (g.y = 2E3 + g.y);
                i = new Date(g.y, g.m, g.d, g.h, g.i, g.s,
                    g.u);
                0 < m && i.setTime(Number(Number(i) + 6E4 * m))
            } else i = new Date(g.y, g.m, g.d, g.h, g.i, g.s, g.u); if (void 0 === b) return i;
            f.masks.hasOwnProperty(b) ? b = f.masks[b] : b || (b = "Y-m-d");
            d = i.getHours();
            e = i.getMinutes();
            g = i.getDate();
            m = i.getMonth() + 1;
            h = i.getTimezoneOffset();
            j = i.getSeconds();
            k = i.getMilliseconds();
            var o = i.getDay(),
                n = i.getFullYear(),
                l = (o + 6) % 7 + 1,
                p = (new Date(n, m - 1, g) - new Date(n, 0, 1)) / 864E5,
                r = {
                    d: c(g),
                    D: f.dayNames[o],
                    j: g,
                    l: f.dayNames[o + 7],
                    N: l,
                    S: f.S(g),
                    w: o,
                    z: p,
                    W: 5 > l ? Math.floor((p + l - 1) / 7) + 1 : Math.floor((p + l - 1) /
                        7) || (4 > ((new Date(n - 1, 0, 1)).getDay() + 6) % 7 ? 53 : 52),
                    F: f.monthNames[m - 1 + 12],
                    m: c(m),
                    M: f.monthNames[m - 1],
                    n: m,
                    t: "?",
                    L: "?",
                    o: "?",
                    Y: n,
                    y: ("" + n).substring(2),
                    a: 12 > d ? f.AmPm[0] : f.AmPm[1],
                    A: 12 > d ? f.AmPm[2] : f.AmPm[3],
                    B: "?",
                    g: d % 12 || 12,
                    G: d,
                    h: c(d % 12 || 12),
                    H: c(d),
                    i: c(e),
                    s: c(j),
                    u: k,
                    e: "?",
                    I: "?",
                    O: (0 < h ? "-" : "+") + c(100 * Math.floor(Math.abs(h) / 60) + Math.abs(h) % 60, 4),
                    P: "?",
                    T: (("" + i).match(/\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g) || [""]).pop().replace(/[^-+\dA-Z]/g,
                        ""),
                    Z: "?",
                    c: "?",
                    r: "?",
                    U: Math.floor(i / 1E3)
                };
            return b.replace(/\\.|[dDjlNSwzWFmMntLoYyaABgGhHisueIOPTZcrU]/g, function(a) {
                return r.hasOwnProperty(a) ? r[a] : a.substring(1)
            })
        },
        jqID: function(a) {
            return ("" + a).replace(/[!"#$%&'()*+,.\/:; <=>?@\[\\\]\^`{|}~]/g, "\\$&")
        },
        guid: 1,
        uidPref: "jqg",
        randId: function(d) {
            return (d || a.jgrid.uidPref) + a.jgrid.guid++
        },
        getAccessor: function(a, e) {
            var b, f, c = [],
                h;
            if ("function" === typeof e) return e(a);
            b = a[e];
            if (void 0 === b) try {
                if ("string" === typeof e && (c = e.split(".")), h = c.length)
                    for (b =
                        a; b && h--;) f = c.shift(), b = b[f]
            } catch (g) {}
            return b
        },
        getXmlData: function(d, e, b) {
            var f = "string" === typeof e ? e.match(/^(.*)\[(\w+)\]$/) : null;
            if ("function" === typeof e) return e(d);
            if (f && f[2]) return f[1] ? a(f[1], d).attr(f[2]) : a(d).attr(f[2]);
            d = a(e, d);
            return b ? d : 0 < d.length ? a(d).text() : void 0
        },
        cellWidth: function() {
            var d = a("<div class='ui-jqgrid' style='left:10000px'><table class='ui-jqgrid-btable' style='width:5px;'><tr class='jqgrow'><td style='width:5px;display:block;'></td></tr></table></div>"),
                e = d.appendTo("body").find("td").width();
            d.remove();
            return 0.1 < Math.abs(e - 5)
        },
        cell_width: !0,
        ajaxOptions: {},
        from: function(d) {
            return new function(d, b) {
                "string" === typeof d && (d = a.data(d));
                var f = this,
                    c = d,
                    h = !0,
                    g = !1,
                    i = b,
                    j = /[\$,%]/g,
                    k = null,
                    m = null,
                    o = 0,
                    n = !1,
                    l = "",
                    p = [],
                    r = !0;
                if ("object" === typeof d && d.push) 0 < d.length && (r = "object" !== typeof d[0] ? !1 : !0);
                else throw "data provides is not an array";
                this._hasData = function() {
                    return null === c ? !1 : 0 === c.length ? !1 : !0
                };
                this._getStr = function(a) {
                    var c = [];
                    g && c.push("jQuery.trim(");
                    c.push("String(" + a + ")");
                    g && c.push(")");
                    h || c.push(".toLowerCase()");
                    return c.join("")
                };
                this._strComp = function(a) {
                    return "string" === typeof a ? ".toString()" : ""
                };
                this._group = function(a, c) {
                    return {
                        field: a.toString(),
                        unique: c,
                        items: []
                    }
                };
                this._toStr = function(c) {
                    g && (c = a.trim(c));
                    c = c.toString().replace(/\\/g, "\\\\").replace(/\"/g, '\\"');
                    return h ? c : c.toLowerCase()
                };
                this._funcLoop = function(b) {
                    var d = [];
                    a.each(c, function(a, c) {
                        d.push(b(c))
                    });
                    return d
                };
                this._append = function(a) {
                    var c;
                    i = null === i ? "" : i + ("" === l ? " && " : l);
                    for (c = 0; c < o; c++) i += "(";
                    n && (i += "!");
                    i +=
                        "(" + a + ")";
                    n = !1;
                    l = "";
                    o = 0
                };
                this._setCommand = function(a, c) {
                    k = a;
                    m = c
                };
                this._resetNegate = function() {
                    n = !1
                };
                this._repeatCommand = function(a, c) {
                    return null === k ? f : null !== a && null !== c ? k(a, c) : null === m || !r ? k(a) : k(m, a)
                };
                this._equals = function(a, c) {
                    return 0 === f._compare(a, c, 1)
                };
                this._compare = function(a, c, b) {
                    var d = Object.prototype.toString;
                    void 0 === b && (b = 1);
                    void 0 === a && (a = null);
                    void 0 === c && (c = null);
                    if (null === a && null === c) return 0;
                    if (null === a && null !== c) return 1;
                    if (null !== a && null === c) return -1;
                    if ("[object Date]" === d.call(a) &&
                        "[object Date]" === d.call(c)) return a < c ? -b : a > c ? b : 0;
                    !h && ("number" !== typeof a && "number" !== typeof c) && (a = "" + a, c = "" + c);
                    return a < c ? -b : a > c ? b : 0
                };
                this._performSort = function() {
                    0 !== p.length && (c = f._doSort(c, 0))
                };
                this._doSort = function(a, c) {
                    var b = p[c].by,
                        d = p[c].dir,
                        e = p[c].type,
                        g = p[c].datefmt,
                        h = p[c].sfunc;
                    if (c === p.length - 1) return f._getOrder(a, b, d, e, g, h);
                    c++;
                    b = f._getGroup(a, b, d, e, g);
                    d = [];
                    for (e = 0; e < b.length; e++) {
                        h = f._doSort(b[e].items, c);
                        for (g = 0; g < h.length; g++) d.push(h[g])
                    }
                    return d
                };
                this._getOrder = function(c, b, d,
                    e, g, i) {
                    var l = [],
                        m = [],
                        k = "a" === d ? 1 : -1,
                        n, o;
                    void 0 === e && (e = "text");
                    o = "float" === e || "number" === e || "currency" === e || "numeric" === e ? function(a) {
                        a = parseFloat(("" + a).replace(j, ""));
                        return isNaN(a) ? Number.NEGATIVE_INFINITY : a
                    } : "int" === e || "integer" === e ? function(a) {
                        return a ? parseFloat(("" + a).replace(j, "")) : Number.NEGATIVE_INFINITY
                    } : "date" === e || "datetime" === e ? function(c) {
                        return a.jgrid.parseDate(g, c).getTime()
                    } : a.isFunction(e) ? e : function(c) {
                        c = c ? a.trim("" + c) : "";
                        return h ? c : c.toLowerCase()
                    };
                    a.each(c, function(c, d) {
                        n =
                            "" !== b ? a.jgrid.getAccessor(d, b) : d;
                        void 0 === n && (n = "");
                        n = o(n, d);
                        m.push({
                            vSort: n,
                            index: c
                        })
                    });
                    a.isFunction(i) ? m.sort(function(a, c) {
                        a = a.vSort;
                        c = c.vSort;
                        return i.call(this, a, c, k)
                    }) : m.sort(function(a, c) {
                        a = a.vSort;
                        c = c.vSort;
                        return f._compare(a, c, k)
                    });
                    for (var e = 0, r = c.length; e < r;) d = m[e].index, l.push(c[d]), e++;
                    return l
                };
                this._getGroup = function(c, b, d, e, g) {
                    var h = [],
                        i = null,
                        j = null,
                        l;
                    a.each(f._getOrder(c, b, d, e, g), function(c, d) {
                        l = a.jgrid.getAccessor(d, b);
                        null == l && (l = "");
                        f._equals(j, l) || (j = l, null !== i && h.push(i), i =
                            f._group(b, l));
                        i.items.push(d)
                    });
                    null !== i && h.push(i);
                    return h
                };
                this.ignoreCase = function() {
                    h = !1;
                    return f
                };
                this.useCase = function() {
                    h = !0;
                    return f
                };
                this.trim = function() {
                    g = !0;
                    return f
                };
                this.noTrim = function() {
                    g = !1;
                    return f
                };
                this.execute = function() {
                    var b = i,
                        d = [];
                    if (null === b) return f;
                    a.each(c, function() {
                        eval(b) && d.push(this)
                    });
                    c = d;
                    return f
                };
                this.data = function() {
                    return c
                };
                this.select = function(b) {
                    f._performSort();
                    if (!f._hasData()) return [];
                    f.execute();
                    if (a.isFunction(b)) {
                        var d = [];
                        a.each(c, function(a, c) {
                            d.push(b(c))
                        });
                        return d
                    }
                    return c
                };
                this.hasMatch = function() {
                    if (!f._hasData()) return !1;
                    f.execute();
                    return 0 < c.length
                };
                this.andNot = function(a, c, b) {
                    n = !n;
                    return f.and(a, c, b)
                };
                this.orNot = function(a, c, b) {
                    n = !n;
                    return f.or(a, c, b)
                };
                this.not = function(a, c, b) {
                    return f.andNot(a, c, b)
                };
                this.and = function(a, c, b) {
                    l = " && ";
                    return void 0 === a ? f : f._repeatCommand(a, c, b)
                };
                this.or = function(a, c, b) {
                    l = " || ";
                    return void 0 === a ? f : f._repeatCommand(a, c, b)
                };
                this.orBegin = function() {
                    o++;
                    return f
                };
                this.orEnd = function() {
                    null !== i && (i += ")");
                    return f
                };
                this.isNot = function(a) {
                    n = !n;
                    return f.is(a)
                };
                this.is = function(a) {
                    f._append("this." + a);
                    f._resetNegate();
                    return f
                };
                this._compareValues = function(c, b, d, e, g) {
                    var h;
                    h = r ? "jQuery.jgrid.getAccessor(this,'" + b + "')" : "this";
                    void 0 === d && (d = null);
                    var i = d,
                        l = void 0 === g.stype ? "text" : g.stype;
                    if (null !== d) switch (l) {
                        case "int":
                        case "integer":
                            i = isNaN(Number(i)) || "" === i ? "0" : i;
                            h = "parseInt(" + h + ",10)";
                            i = "parseInt(" + i + ",10)";
                            break;
                        case "float":
                        case "number":
                        case "numeric":
                            i = ("" + i).replace(j, "");
                            i = isNaN(Number(i)) || "" === i ? "0" :
                                i;
                            h = "parseFloat(" + h + ")";
                            i = "parseFloat(" + i + ")";
                            break;
                        case "date":
                        case "datetime":
                            i = "" + a.jgrid.parseDate(g.newfmt || "Y-m-d", i).getTime();
                            h = 'jQuery.jgrid.parseDate("' + g.srcfmt + '",' + h + ").getTime()";
                            break;
                        default:
                            h = f._getStr(h), i = f._getStr('"' + f._toStr(i) + '"')
                    }
                    f._append(h + " " + e + " " + i);
                    f._setCommand(c, b);
                    f._resetNegate();
                    return f
                };
                this.equals = function(a, c, b) {
                    return f._compareValues(f.equals, a, c, "==", b)
                };
                this.notEquals = function(a, c, b) {
                    return f._compareValues(f.equals, a, c, "!==", b)
                };
                this.isNull = function(a,
                    c, b) {
                    return f._compareValues(f.equals, a, null, "===", b)
                };
                this.greater = function(a, c, b) {
                    return f._compareValues(f.greater, a, c, ">", b)
                };
                this.less = function(a, c, b) {
                    return f._compareValues(f.less, a, c, "<", b)
                };
                this.greaterOrEquals = function(a, c, b) {
                    return f._compareValues(f.greaterOrEquals, a, c, ">=", b)
                };
                this.lessOrEquals = function(a, c, b) {
                    return f._compareValues(f.lessOrEquals, a, c, "<=", b)
                };
                this.startsWith = function(c, b) {
                    var d = null == b ? c : b,
                        d = g ? a.trim(d.toString()).length : d.toString().length;
                    r ? f._append(f._getStr("jQuery.jgrid.getAccessor(this,'" +
                        c + "')") + ".substr(0," + d + ") == " + f._getStr('"' + f._toStr(b) + '"')) : (null != b && (d = g ? a.trim(b.toString()).length : b.toString().length), f._append(f._getStr("this") + ".substr(0," + d + ") == " + f._getStr('"' + f._toStr(c) + '"')));
                    f._setCommand(f.startsWith, c);
                    f._resetNegate();
                    return f
                };
                this.endsWith = function(c, b) {
                    var d = null == b ? c : b,
                        d = g ? a.trim(d.toString()).length : d.toString().length;
                    r ? f._append(f._getStr("jQuery.jgrid.getAccessor(this,'" + c + "')") + ".substr(" + f._getStr("jQuery.jgrid.getAccessor(this,'" + c + "')") + ".length-" +
                        d + "," + d + ') == "' + f._toStr(b) + '"') : f._append(f._getStr("this") + ".substr(" + f._getStr("this") + '.length-"' + f._toStr(c) + '".length,"' + f._toStr(c) + '".length) == "' + f._toStr(c) + '"');
                    f._setCommand(f.endsWith, c);
                    f._resetNegate();
                    return f
                };
                this.contains = function(a, c) {
                    r ? f._append(f._getStr("jQuery.jgrid.getAccessor(this,'" + a + "')") + '.indexOf("' + f._toStr(c) + '",0) > -1') : f._append(f._getStr("this") + '.indexOf("' + f._toStr(a) + '",0) > -1');
                    f._setCommand(f.contains, a);
                    f._resetNegate();
                    return f
                };
                this.groupBy = function(a,
                    b, d, e) {
                    return !f._hasData() ? null : f._getGroup(c, a, b, d, e)
                };
                this.orderBy = function(c, b, d, e, g) {
                    b = null == b ? "a" : a.trim(b.toString().toLowerCase());
                    null == d && (d = "text");
                    null == e && (e = "Y-m-d");
                    null == g && (g = !1);
                    if ("desc" === b || "descending" === b) b = "d";
                    if ("asc" === b || "ascending" === b) b = "a";
                    p.push({
                        by: c,
                        dir: b,
                        type: d,
                        datefmt: e,
                        sfunc: g
                    });
                    return f
                };
                return f
            }(d, null)
        },
        getMethod: function(d) {
            return this.getAccessor(a.fn.jqGrid, d)
        },
        extend: function(d) {
            a.extend(a.fn.jqGrid, d);
            this.no_legacy_api || a.fn.extend(d)
        }
    });
    a.fn.jqGrid = function(d) {
        if ("string" ===
            typeof d) {
            var e = a.jgrid.getMethod(d);
            if (!e) throw "jqGrid - No such method: " + d;
            var b = a.makeArray(arguments).slice(1);
            return e.apply(this, b)
        }
        return this.each(function() {
            if (!this.grid) {
                var b = a.extend(!0, {
                        url: "",
                        height: 150,
                        page: 1,
                        rowNum: 20,
                        rowTotal: null,
                        records: 0,
                        pager: "",
                        pgbuttons: !0,
                        pginput: !0,
                        colModel: [],
                        rowList: [],
                        colNames: [],
                        sortorder: "asc",
                        sortname: "",
                        datatype: "xml",
                        mtype: "GET",
                        altRows: !1,
                        selarrrow: [],
                        savedRow: [],
                        shrinkToFit: !0,
                        xmlReader: {},
                        jsonReader: {},
                        subGrid: !1,
                        subGridModel: [],
                        reccount: 0,
                        lastpage: 0,
                        lastsort: 0,
                        selrow: null,
                        beforeSelectRow: null,
                        onSelectRow: null,
                        onSortCol: null,
                        ondblClickRow: null,
                        onRightClickRow: null,
                        onPaging: null,
                        onSelectAll: null,
                        onInitGrid: null,
                        loadComplete: null,
                        gridComplete: null,
                        loadError: null,
                        loadBeforeSend: null,
                        afterInsertRow: null,
                        beforeRequest: null,
                        beforeProcessing: null,
                        onHeaderClick: null,
                        viewrecords: !1,
                        loadonce: !1,
                        multiselect: !1,
                        multikey: !1,
                        editurl: null,
                        search: !1,
                        caption: "",
                        hidegrid: !0,
                        hiddengrid: !1,
                        postData: {},
                        userData: {},
                        treeGrid: !1,
                        treeGridModel: "nested",
                        treeReader: {},
                        treeANode: -1,
                        ExpandColumn: null,
                        tree_root_level: 0,
                        prmNames: {
                            page: "page",
                            rows: "rows",
                            sort: "sidx",
                            order: "sord",
                            search: "_search",
                            nd: "nd",
                            id: "id",
                            oper: "oper",
                            editoper: "edit",
                            addoper: "add",
                            deloper: "del",
                            subgridid: "id",
                            npage: null,
                            totalrows: "totalrows"
                        },
                        forceFit: !1,
                        gridstate: "visible",
                        cellEdit: !1,
                        cellsubmit: "remote",
                        nv: 0,
                        loadui: "enable",
                        toolbar: [!1, ""],
                        scroll: !1,
                        multiboxonly: !1,
                        deselectAfterSort: !0,
                        scrollrows: !1,
                        autowidth: !1,
                        scrollOffset: 18,
                        cellLayout: 5,
                        subGridWidth: 20,
                        multiselectWidth: 20,
                        gridview: !1,
                        rownumWidth: 25,
                        rownumbers: !1,
                        pagerpos: "center",
                        recordpos: "right",
                        footerrow: !1,
                        userDataOnFooter: !1,
                        hoverrows: !0,
                        altclass: "ui-priority-secondary",
                        viewsortcols: [!1, "vertical", !0],
                        resizeclass: "",
                        autoencode: !1,
                        remapColumns: [],
                        ajaxGridOptions: {},
                        direction: "ltr",
                        toppager: !1,
                        headertitles: !1,
                        scrollTimeout: 40,
                        data: [],
                        _index: {},
                        grouping: !1,
                        groupingView: {
                            groupField: [],
                            groupOrder: [],
                            groupText: [],
                            groupColumnShow: [],
                            groupSummary: [],
                            showSummaryOnHide: !1,
                            sortitems: [],
                            sortnames: [],
                            summary: [],
                            summaryval: [],
                            plusicon: "ui-icon-circlesmall-plus",
                            minusicon: "ui-icon-circlesmall-minus",
                            displayField: [],
                            groupSummaryPos: [],
                            formatDisplayField: [],
                            _locgr: !1
                        },
                        ignoreCase: !1,
                        cmTemplate: {},
                        idPrefix: "",
                        multiSort: !1,
                        minColWidth: 33
                    }, a.jgrid.defaults, d || {}),
                    c = this,
                    e = {
                        headers: [],
                        cols: [],
                        footers: [],
                        dragStart: function(d, e, g) {
                            var i = a(this.bDiv).offset().left;
                            this.resizing = {
                                idx: d,
                                startX: e.clientX,
                                sOL: e.clientX - i
                            };
                            this.hDiv.style.cursor = "col-resize";
                            this.curGbox = a("#rs_m" + a.jgrid.jqID(b.id), "#gbox_" + a.jgrid.jqID(b.id));
                            this.curGbox.css({
                                display: "block",
                                left: e.clientX -
                                    i,
                                top: g[1],
                                height: g[2]
                            });
                            a(c).triggerHandler("jqGridResizeStart", [e, d]);
                            a.isFunction(b.resizeStart) && b.resizeStart.call(c, e, d);
                            document.onselectstart = function() {
                                return !1
                            }
                        },
                        dragMove: function(a) {
                            if (this.resizing) {
                                var c = a.clientX - this.resizing.startX,
                                    a = this.headers[this.resizing.idx],
                                    d = "ltr" === b.direction ? a.width + c : a.width - c,
                                    e;
                                33 < d && (this.curGbox.css({
                                    left: this.resizing.sOL + c
                                }), !0 === b.forceFit ? (e = this.headers[this.resizing.idx + b.nv], c = "ltr" === b.direction ? e.width - c : e.width + c, c > b.minColWidth && (a.newWidth =
                                    d, e.newWidth = c)) : (this.newWidth = "ltr" === b.direction ? b.tblwidth + c : b.tblwidth - c, a.newWidth = d))
                            }
                        },
                        dragEnd: function() {
                            this.hDiv.style.cursor = "default";
                            if (this.resizing) {
                                var d = this.resizing.idx,
                                    e = this.headers[d].newWidth || this.headers[d].width,
                                    e = parseInt(e, 10);
                                this.resizing = !1;
                                a("#rs_m" + a.jgrid.jqID(b.id)).css("display", "none");
                                b.colModel[d].width = e;
                                this.headers[d].width = e;
                                this.headers[d].el.style.width = e + "px";
                                this.cols[d].style.width = e + "px";
                                0 < this.footers.length && (this.footers[d].style.width = e + "px");
                                !0 === b.forceFit ? (e = this.headers[d + b.nv].newWidth || this.headers[d + b.nv].width, this.headers[d + b.nv].width = e, this.headers[d + b.nv].el.style.width = e + "px", this.cols[d + b.nv].style.width = e + "px", 0 < this.footers.length && (this.footers[d + b.nv].style.width = e + "px"), b.colModel[d + b.nv].width = e) : (b.tblwidth = this.newWidth || b.tblwidth, a("table:first", this.bDiv).css("width", b.tblwidth + "px"), a("table:first", this.hDiv).css("width", b.tblwidth + "px"), this.hDiv.scrollLeft = this.bDiv.scrollLeft, b.footerrow && (a("table:first",
                                    this.sDiv).css("width", b.tblwidth + "px"), this.sDiv.scrollLeft = this.bDiv.scrollLeft));
                                a(c).triggerHandler("jqGridResizeStop", [e, d]);
                                a.isFunction(b.resizeStop) && b.resizeStop.call(c, e, d)
                            }
                            this.curGbox = null;
                            document.onselectstart = function() {
                                return !0
                            }
                        },
                        populateVisible: function() {
                            e.timer && clearTimeout(e.timer);
                            e.timer = null;
                            var c = a(e.bDiv).height();
                            if (c) {
                                var d = a("table:first", e.bDiv),
                                    g, i;
                                if (d[0].rows.length) try {
                                    i = (g = d[0].rows[1]) ? a(g).outerHeight() || e.prevRowHeight : e.prevRowHeight
                                } catch (j) {
                                    i = e.prevRowHeight
                                }
                                if (i) {
                                    e.prevRowHeight =
                                        i;
                                    var l = b.rowNum;
                                    g = e.scrollTop = e.bDiv.scrollTop;
                                    var m = Math.round(d.position().top) - g,
                                        k = m + d.height();
                                    i *= l;
                                    var n, o, r;
                                    if (k < c && 0 >= m && (void 0 === b.lastpage || (parseInt((k + g + i - 1) / i, 10) || 0) <= b.lastpage)) o = parseInt((c - k + i - 1) / i, 10) || 1, 0 <= k || 2 > o || !0 === b.scroll ? (n = (Math.round((k + g) / i) || 0) + 1, m = -1) : m = 1;
                                    0 < m && (n = (parseInt(g / i, 10) || 0) + 1, o = (parseInt((g + c) / i, 10) || 0) + 2 - n, r = !0);
                                    if (o && (!b.lastpage || !(n > b.lastpage || 1 === b.lastpage || n === b.page && n === b.lastpage))) e.hDiv.loading ? e.timer = setTimeout(e.populateVisible, b.scrollTimeout) :
                                        (b.page = n, r && (e.selectionPreserver(d[0]), e.emptyRows.call(d[0], !1, !1)), e.populate(o))
                                }
                            }
                        },
                        scrollGrid: function(a) {
                            if (b.scroll) {
                                var c = e.bDiv.scrollTop;
                                void 0 === e.scrollTop && (e.scrollTop = 0);
                                c !== e.scrollTop && (e.scrollTop = c, e.timer && clearTimeout(e.timer), e.timer = setTimeout(e.populateVisible, b.scrollTimeout))
                            }
                            e.hDiv.scrollLeft = e.bDiv.scrollLeft;
                            b.footerrow && (e.sDiv.scrollLeft = e.bDiv.scrollLeft);
                            a && a.stopPropagation()
                        },
                        selectionPreserver: function(c) {
                            var b = c.p,
                                d = b.selrow,
                                e = b.selarrrow ? a.makeArray(b.selarrrow) :
                                null,
                                f = c.grid.bDiv.scrollLeft,
                                g = function() {
                                    var i;
                                    b.selrow = null;
                                    b.selarrrow = [];
                                    if (b.multiselect && e && 0 < e.length)
                                        for (i = 0; i < e.length; i++) e[i] !== d && a(c).jqGrid("setSelection", e[i], !1, null);
                                    d && a(c).jqGrid("setSelection", d, !1, null);
                                    c.grid.bDiv.scrollLeft = f;
                                    a(c).unbind(".selectionPreserver", g)
                                };
                            a(c).bind("jqGridGridComplete.selectionPreserver", g)
                        }
                    };
                if ("TABLE" !== this.tagName.toUpperCase() || null == this.id) alert("Element is not a table or has no id!");
                else if (void 0 !== document.documentMode && 5 >= document.documentMode) alert("Grid can not be used in this ('quirks') mode!");
                else {
                    a(this).empty().attr("tabindex", "0");
                    this.p = b;
                    this.p.useProp = !!a.fn.prop;
                    var g, i;
                    if (0 === this.p.colNames.length)
                        for (g = 0; g < this.p.colModel.length; g++) this.p.colNames[g] = this.p.colModel[g].label || this.p.colModel[g].name;
                    if (this.p.colNames.length !== this.p.colModel.length) alert(a.jgrid.errors.model);
                    else {
                        var j = a("<div class='ui-jqgrid-view'></div>"),
                            k = a.jgrid.msie;
                        c.p.direction = a.trim(c.p.direction.toLowerCase()); - 1 === a.inArray(c.p.direction, ["ltr", "rtl"]) && (c.p.direction = "ltr");
                        i = c.p.direction;
                        a(j).insertBefore(this);
                        a(this).removeClass("scroll").appendTo(j);
                        var m = a("<div class='ui-jqgrid ui-widget ui-widget-content ui-corner-all'></div>");
                        a(m).attr({
                            id: "gbox_" + this.id,
                            dir: i
                        }).insertBefore(j);
                        a(j).attr("id", "gview_" + this.id).appendTo(m);
                        a("<div class='ui-widget-overlay jqgrid-overlay' id='lui_" + this.id + "'></div>").insertBefore(j);
                        a("<div class='loading ui-state-default ui-state-active' id='load_" + this.id + "'>" + this.p.loadtext + "</div>").insertBefore(j);
                        a(this).attr({
                            cellspacing: "0",
                            cellpadding: "0",
                            border: "0",
                            role: "grid",
                            "aria-multiselectable": !!this.p.multiselect,
                            "aria-labelledby": "gbox_" + this.id
                        });
                        var o = function(a, c) {
                                a = parseInt(a, 10);
                                return isNaN(a) ? c || 0 : a
                            },
                            n = function(b, d, f, g, i, j) {
                                var l = c.p.colModel[b],
                                    m = l.align,
                                    k = 'style="',
                                    n = l.classes,
                                    o = l.name,
                                    r = [];
                                m && (k = k + ("text-align:" + m + ";"));
                                l.hidden === true && (k = k + "display:none;");
                                if (d === 0) k = k + ("width: " + e.headers[b].width + "px;");
                                else if (l.cellattr && a.isFunction(l.cellattr))
                                    if ((b = l.cellattr.call(c, i, f, g, l, j)) && typeof b === "string") {
                                        b = b.replace(/style/i, "style").replace(/title/i,
                                            "title");
                                        if (b.indexOf("title") > -1) l.title = false;
                                        b.indexOf("class") > -1 && (n = void 0);
                                        r = b.replace("-style", "-sti").split(/style/);
                                        if (r.length === 2) {
                                            r[1] = a.trim(r[1].replace("-sti", "-style").replace("=", ""));
                                            if (r[1].indexOf("'") === 0 || r[1].indexOf('"') === 0) r[1] = r[1].substring(1);
                                            k = k + r[1].replace(/'/gi, '"')
                                        } else k = k + '"'
                                    }
                                if (!r.length) {
                                    r[0] = "";
                                    k = k + '"'
                                }
                                k = k + ((n !== void 0 ? ' class="' + n + '"' : "") + (l.title && f ? ' title="' + a.jgrid.stripHtml(f) + '"' : ""));
                                k = k + (' aria-describedby="' + c.p.id + "_" + o + '"');
                                return k + r[0]
                            },
                            l = function(b) {
                                return b ==
                                    null || b === "" ? "&#160;" : c.p.autoencode ? a.jgrid.htmlEncode(b) : "" + b
                            },
                            p = function(b, d, e, f, g) {
                                var i = c.p.colModel[e];
                                if (i.formatter !== void 0) {
                                    b = "" + c.p.idPrefix !== "" ? a.jgrid.stripPref(c.p.idPrefix, b) : b;
                                    b = {
                                        rowId: b,
                                        colModel: i,
                                        gid: c.p.id,
                                        pos: e
                                    };
                                    d = a.isFunction(i.formatter) ? i.formatter.call(c, d, b, f, g) : a.fmatter ? a.fn.fmatter.call(c, i.formatter, d, b, f, g) : l(d)
                                } else d = l(d);
                                return d
                            },
                            r = function(a, c, b, d, e, f) {
                                c = p(a, c, b, e, "add");
                                return '<td role="gridcell" ' + n(b, d, c, e, a, f) + ">" + c + "</td>"
                            },
                            q = function(a, b, d, e) {
                                e = '<input role="checkbox" type="checkbox" id="jqg_' +
                                    c.p.id + "_" + a + '" class="cbox" name="jqg_' + c.p.id + "_" + a + '"' + (e ? 'checked="checked"' : "") + "/>";
                                return '<td role="gridcell" ' + n(b, d, "", null, a, true) + ">" + e + "</td>"
                            },
                            s = function(a, c, b, d) {
                                b = (parseInt(b, 10) - 1) * parseInt(d, 10) + 1 + c;
                                return '<td role="gridcell" class="ui-state-default jqgrid-rownum" ' + n(a, c, b, null, c, true) + ">" + b + "</td>"
                            },
                            t = function(a) {
                                var b, d = [],
                                    e = 0,
                                    f;
                                for (f = 0; f < c.p.colModel.length; f++) {
                                    b = c.p.colModel[f];
                                    if (b.name !== "cb" && b.name !== "subgrid" && b.name !== "rn") {
                                        d[e] = a === "local" ? b.name : a === "xml" || a === "xmlstring" ?
                                            b.xmlmap || b.name : b.jsonmap || b.name;
                                        if (c.p.keyName !== false && b.key === true) c.p.keyName = d[e];
                                        e++
                                    }
                                }
                                return d
                            },
                            w = function(b) {
                                var d = c.p.remapColumns;
                                if (!d || !d.length) d = a.map(c.p.colModel, function(a, c) {
                                    return c
                                });
                                b && (d = a.map(d, function(a) {
                                    return a < b ? null : a - b
                                }));
                                return d
                            },
                            v = function(c, b) {
                                var d;
                                if (this.p.deepempty) a(this.rows).slice(1).remove();
                                else {
                                    d = this.rows.length > 0 ? this.rows[0] : null;
                                    a(this.firstChild).empty().append(d)
                                } if (c && this.p.scroll) {
                                    a(this.grid.bDiv.firstChild).css({
                                        height: "auto"
                                    });
                                    a(this.grid.bDiv.firstChild.firstChild).css({
                                        height: 0,
                                        display: "none"
                                    });
                                    if (this.grid.bDiv.scrollTop !== 0) this.grid.bDiv.scrollTop = 0
                                }
                                if (b === true && this.p.treeGrid) {
                                    this.p.data = [];
                                    this.p._index = {}
                                }
                            },
                            x = function() {
                                var b = c.p.data.length,
                                    d, e, f;
                                d = c.p.keyName === false || c.p.loadonce === true ? c.p.localReader.id : c.p.keyName;
                                for (e = 0; e < b; e++) {
                                    f = a.jgrid.getAccessor(c.p.data[e], d);
                                    f === void 0 && (f = "" + (e + 1));
                                    c.p._index[f] = e
                                }
                            },
                            H = function(b, d, e, f, g, i) {
                                var j = "-1",
                                    h = "",
                                    l, d = d ? "display:none;" : "",
                                    e = "ui-widget-content jqgrow ui-row-" + c.p.direction + (e ? " " + e : "") + (i ? " ui-state-highlight" :
                                        ""),
                                    i = a(c).triggerHandler("jqGridRowAttr", [f, g, b]);
                                typeof i !== "object" && (i = a.isFunction(c.p.rowattr) ? c.p.rowattr.call(c, f, g, b) : {});
                                if (!a.isEmptyObject(i)) {
                                    if (i.hasOwnProperty("id")) {
                                        b = i.id;
                                        delete i.id
                                    }
                                    if (i.hasOwnProperty("tabindex")) {
                                        j = i.tabindex;
                                        delete i.tabindex
                                    }
                                    if (i.hasOwnProperty("style")) {
                                        d = d + i.style;
                                        delete i.style
                                    }
                                    if (i.hasOwnProperty("class")) {
                                        e = e + (" " + i["class"]);
                                        delete i["class"]
                                    }
                                    try {
                                        delete i.role
                                    } catch (m) {}
                                    for (l in i) i.hasOwnProperty(l) && (h = h + (" " + l + "=" + i[l]))
                                }
                                return '<tr role="row" id="' +
                                    b + '" tabindex="' + j + '" class="' + e + '"' + (d === "" ? "" : ' style="' + d + '"') + h + ">"
                            },
                            y = function(b, d, e, f, g) {
                                var i = new Date,
                                    j = c.p.datatype !== "local" && c.p.loadonce || c.p.datatype === "xmlstring",
                                    h = c.p.xmlReader,
                                    l = c.p.datatype === "local" ? "local" : "xml";
                                if (j) {
                                    c.p.data = [];
                                    c.p._index = {};
                                    c.p.localReader.id = "_id_"
                                }
                                c.p.reccount = 0;
                                if (a.isXMLDoc(b)) {
                                    if (c.p.treeANode === -1 && !c.p.scroll) {
                                        v.call(c, false, true);
                                        e = 1
                                    } else e = e > 1 ? e : 1;
                                    var m = a(c),
                                        k, n, p = 0,
                                        y, E = c.p.multiselect === true ? 1 : 0,
                                        x = 0,
                                        u, K = c.p.rownumbers === true ? 1 : 0,
                                        D, A = [],
                                        L, z = {},
                                        C, G,
                                        F = [],
                                        M = c.p.altRows === true ? c.p.altclass : "",
                                        ba;
                                    if (c.p.subGrid === true) {
                                        x = 1;
                                        u = a.jgrid.getMethod("addSubGridCell")
                                    }
                                    h.repeatitems || (A = t(l));
                                    D = c.p.keyName === false ? a.isFunction(h.id) ? h.id.call(c, b) : h.id : c.p.keyName;
                                    l = ("" + D).indexOf("[") === -1 ? A.length ? function(c, b) {
                                        return a(D, c).text() || b
                                    } : function(c, b) {
                                        return a(h.cell, c).eq(D).text() || b
                                    } : function(a, c) {
                                        return a.getAttribute(D.replace(/[\[\]]/g, "")) || c
                                    };
                                    c.p.userData = {};
                                    c.p.page = o(a.jgrid.getXmlData(b, h.page), c.p.page);
                                    c.p.lastpage = o(a.jgrid.getXmlData(b, h.total),
                                        1);
                                    c.p.records = o(a.jgrid.getXmlData(b, h.records));
                                    a.isFunction(h.userdata) ? c.p.userData = h.userdata.call(c, b) || {} : a.jgrid.getXmlData(b, h.userdata, true).each(function() {
                                        c.p.userData[this.getAttribute("name")] = a(this).text()
                                    });
                                    b = a.jgrid.getXmlData(b, h.root, true);
                                    (b = a.jgrid.getXmlData(b, h.row, true)) || (b = []);
                                    var B = b.length,
                                        J = 0,
                                        I = [],
                                        Q = parseInt(c.p.rowNum, 10),
                                        V = c.p.scroll ? a.jgrid.randId() : 1;
                                    if (B > 0 && c.p.page <= 0) c.p.page = 1;
                                    if (b && B) {
                                        g && (Q = Q * (g + 1));
                                        var g = a.isFunction(c.p.afterInsertRow),
                                            S = false,
                                            R;
                                        if (c.p.grouping) {
                                            S =
                                                c.p.groupingView.groupCollapse === true;
                                            R = a.jgrid.getMethod("groupingPrepare")
                                        }
                                        for (; J < B;) {
                                            C = b[J];
                                            G = l(C, V + J);
                                            G = c.p.idPrefix + G;
                                            k = e === 0 ? 0 : e + 1;
                                            ba = (k + J) % 2 === 1 ? M : "";
                                            var O = F.length;
                                            F.push("");
                                            K && F.push(s(0, J, c.p.page, c.p.rowNum));
                                            E && F.push(q(G, K, J, false));
                                            x && F.push(u.call(m, E + K, J + e));
                                            if (h.repeatitems) {
                                                L || (L = w(E + x + K));
                                                var N = a.jgrid.getXmlData(C, h.cell, true);
                                                a.each(L, function(a) {
                                                    var b = N[this];
                                                    if (!b) return false;
                                                    y = b.textContent || b.text;
                                                    z[c.p.colModel[a + E + x + K].name] = y;
                                                    F.push(r(G, y, a + E + x + K, J + e, C, z))
                                                })
                                            } else
                                                for (k =
                                                    0; k < A.length; k++) {
                                                    y = a.jgrid.getXmlData(C, A[k]);
                                                    z[c.p.colModel[k + E + x + K].name] = y;
                                                    F.push(r(G, y, k + E + x + K, J + e, C, z))
                                                }
                                            F[O] = H(G, S, ba, z, C, false);
                                            F.push("</tr>");
                                            if (c.p.grouping) {
                                                I.push(F);
                                                c.p.groupingView._locgr || R.call(m, z, J);
                                                F = []
                                            }
                                            if (j || c.p.treeGrid === true) {
                                                z._id_ = a.jgrid.stripPref(c.p.idPrefix, G);
                                                c.p.data.push(z);
                                                c.p._index[z._id_] = c.p.data.length - 1
                                            }
                                            if (c.p.gridview === false) {
                                                a("tbody:first", d).append(F.join(""));
                                                m.triggerHandler("jqGridAfterInsertRow", [G, z, C]);
                                                g && c.p.afterInsertRow.call(c, G, z, C);
                                                F = []
                                            }
                                            z = {};
                                            p++;
                                            J++;
                                            if (p === Q) break
                                        }
                                    }
                                    if (c.p.gridview === true) {
                                        n = c.p.treeANode > -1 ? c.p.treeANode : 0;
                                        if (c.p.grouping) {
                                            if (!j) {
                                                m.jqGrid("groupingRender", I, c.p.colModel.length, c.p.page, Q);
                                                I = null
                                            }
                                        } else c.p.treeGrid === true && n > 0 ? a(c.rows[n]).after(F.join("")) : a("tbody:first", d).append(F.join(""))
                                    }
                                    if (c.p.subGrid === true) try {
                                        m.jqGrid("addSubGrid", E + K)
                                    } catch (W) {}
                                    c.p.totaltime = new Date - i;
                                    if (p > 0 && c.p.records === 0) c.p.records = B;
                                    F = null;
                                    if (c.p.treeGrid === true) try {
                                        m.jqGrid("setTreeNode", n + 1, p + n + 1)
                                    } catch (Z) {}
                                    if (!c.p.treeGrid && !c.p.scroll) c.grid.bDiv.scrollTop =
                                        0;
                                    c.p.reccount = p;
                                    c.p.treeANode = -1;
                                    c.p.userDataOnFooter && m.jqGrid("footerData", "set", c.p.userData, true);
                                    if (j) {
                                        c.p.records = B;
                                        c.p.lastpage = Math.ceil(B / Q)
                                    }
                                    f || c.updatepager(false, true);
                                    if (j) {
                                        for (; p < B;) {
                                            C = b[p];
                                            G = l(C, p + V);
                                            G = c.p.idPrefix + G;
                                            if (h.repeatitems) {
                                                L || (L = w(E + x + K));
                                                var Y = a.jgrid.getXmlData(C, h.cell, true);
                                                a.each(L, function(a) {
                                                    var b = Y[this];
                                                    if (!b) return false;
                                                    y = b.textContent || b.text;
                                                    z[c.p.colModel[a + E + x + K].name] = y
                                                })
                                            } else
                                                for (k = 0; k < A.length; k++) {
                                                    y = a.jgrid.getXmlData(C, A[k]);
                                                    z[c.p.colModel[k + E + x + K].name] =
                                                        y
                                                }
                                            z._id_ = a.jgrid.stripPref(c.p.idPrefix, G);
                                            c.p.grouping && R.call(m, z, p);
                                            c.p.data.push(z);
                                            c.p._index[z._id_] = c.p.data.length - 1;
                                            z = {};
                                            p++
                                        }
                                        if (c.p.grouping) {
                                            c.p.groupingView._locgr = true;
                                            m.jqGrid("groupingRender", I, c.p.colModel.length, c.p.page, Q);
                                            I = null
                                        }
                                    }
                                }
                            },
                            D = function(b, d, e, f, g) {
                                var i = new Date;
                                if (b) {
                                    if (c.p.treeANode === -1 && !c.p.scroll) {
                                        v.call(c, false, true);
                                        e = 1
                                    } else e = e > 1 ? e : 1;
                                    var j, h = c.p.datatype !== "local" && c.p.loadonce || c.p.datatype === "jsonstring";
                                    if (h) {
                                        c.p.data = [];
                                        c.p._index = {};
                                        c.p.localReader.id = "_id_"
                                    }
                                    c.p.reccount =
                                        0;
                                    if (c.p.datatype === "local") {
                                        d = c.p.localReader;
                                        j = "local"
                                    } else {
                                        d = c.p.jsonReader;
                                        j = "json"
                                    }
                                    var l = a(c),
                                        m = 0,
                                        k, n, p, y = [],
                                        E = c.p.multiselect ? 1 : 0,
                                        x = c.p.subGrid === true ? 1 : 0,
                                        K, u = c.p.rownumbers === true ? 1 : 0,
                                        D = w(E + x + u);
                                    j = t(j);
                                    var z, A, F, G = {},
                                        L, C, J = [],
                                        ba = c.p.altRows === true ? c.p.altclass : "",
                                        B;
                                    c.p.page = o(a.jgrid.getAccessor(b, d.page), c.p.page);
                                    c.p.lastpage = o(a.jgrid.getAccessor(b, d.total), 1);
                                    c.p.records = o(a.jgrid.getAccessor(b, d.records));
                                    c.p.userData = a.jgrid.getAccessor(b, d.userdata) || {};
                                    x && (K = a.jgrid.getMethod("addSubGridCell"));
                                    F = c.p.keyName === false ? a.isFunction(d.id) ? d.id.call(c, b) : d.id : c.p.keyName;
                                    A = a.jgrid.getAccessor(b, d.root);
                                    A == null && a.isArray(b) && (A = b);
                                    A || (A = []);
                                    b = A.length;
                                    n = 0;
                                    if (b > 0 && c.p.page <= 0) c.p.page = 1;
                                    var M = parseInt(c.p.rowNum, 10),
                                        I = c.p.scroll ? a.jgrid.randId() : 1,
                                        Q = false,
                                        R;
                                    g && (M = M * (g + 1));
                                    c.p.datatype === "local" && !c.p.deselectAfterSort && (Q = true);
                                    var V = a.isFunction(c.p.afterInsertRow),
                                        S = [],
                                        O = false,
                                        N;
                                    if (c.p.grouping) {
                                        O = c.p.groupingView.groupCollapse === true;
                                        N = a.jgrid.getMethod("groupingPrepare")
                                    }
                                    for (; n < b;) {
                                        g = A[n];
                                        C = a.jgrid.getAccessor(g, F);
                                        if (C === void 0) {
                                            typeof F === "number" && c.p.colModel[F + E + x + u] != null && (C = a.jgrid.getAccessor(g, c.p.colModel[F + E + x + u].name));
                                            if (C === void 0) {
                                                C = I + n;
                                                if (y.length === 0 && d.cell) {
                                                    k = a.jgrid.getAccessor(g, d.cell) || g;
                                                    C = k != null && k[F] !== void 0 ? k[F] : C
                                                }
                                            }
                                        }
                                        C = c.p.idPrefix + C;
                                        k = e === 1 ? 0 : e;
                                        B = (k + n) % 2 === 1 ? ba : "";
                                        Q && (R = c.p.multiselect ? a.inArray(C, c.p.selarrrow) !== -1 : C === c.p.selrow);
                                        var W = J.length;
                                        J.push("");
                                        u && J.push(s(0, n, c.p.page, c.p.rowNum));
                                        E && J.push(q(C, u, n, R));
                                        x && J.push(K.call(l, E + u, n + e));
                                        z = j;
                                        if (d.repeatitems) {
                                            d.cell &&
                                                (g = a.jgrid.getAccessor(g, d.cell) || g);
                                            a.isArray(g) && (z = D)
                                        }
                                        for (p = 0; p < z.length; p++) {
                                            k = a.jgrid.getAccessor(g, z[p]);
                                            G[c.p.colModel[p + E + x + u].name] = k;
                                            J.push(r(C, k, p + E + x + u, n + e, g, G))
                                        }
                                        J[W] = H(C, O, B, G, g, R);
                                        J.push("</tr>");
                                        if (c.p.grouping) {
                                            S.push(J);
                                            c.p.groupingView._locgr || N.call(l, G, n);
                                            J = []
                                        }
                                        if (h || c.p.treeGrid === true) {
                                            G._id_ = a.jgrid.stripPref(c.p.idPrefix, C);
                                            c.p.data.push(G);
                                            c.p._index[G._id_] = c.p.data.length - 1
                                        }
                                        if (c.p.gridview === false) {
                                            a("#" + a.jgrid.jqID(c.p.id) + " tbody:first").append(J.join(""));
                                            l.triggerHandler("jqGridAfterInsertRow", [C, G, g]);
                                            V && c.p.afterInsertRow.call(c, C, G, g);
                                            J = []
                                        }
                                        G = {};
                                        m++;
                                        n++;
                                        if (m === M) break
                                    }
                                    if (c.p.gridview === true) {
                                        L = c.p.treeANode > -1 ? c.p.treeANode : 0;
                                        if (c.p.grouping) {
                                            if (!h) {
                                                l.jqGrid("groupingRender", S, c.p.colModel.length, c.p.page, M);
                                                S = null
                                            }
                                        } else c.p.treeGrid === true && L > 0 ? a(c.rows[L]).after(J.join("")) : a("#" + a.jgrid.jqID(c.p.id) + " tbody:first").append(J.join(""))
                                    }
                                    if (c.p.subGrid === true) try {
                                        l.jqGrid("addSubGrid", E + u)
                                    } catch (Z) {}
                                    c.p.totaltime = new Date - i;
                                    if (m > 0 && c.p.records === 0) c.p.records = b;
                                    if (c.p.treeGrid === true) try {
                                        l.jqGrid("setTreeNode",
                                            L + 1, m + L + 1)
                                    } catch (Y) {}
                                    if (!c.p.treeGrid && !c.p.scroll) c.grid.bDiv.scrollTop = 0;
                                    c.p.reccount = m;
                                    c.p.treeANode = -1;
                                    c.p.userDataOnFooter && l.jqGrid("footerData", "set", c.p.userData, true);
                                    if (h) {
                                        c.p.records = b;
                                        c.p.lastpage = Math.ceil(b / M)
                                    }
                                    f || c.updatepager(false, true);
                                    if (h) {
                                        for (; m < b && A[m];) {
                                            g = A[m];
                                            C = a.jgrid.getAccessor(g, F);
                                            if (C === void 0) {
                                                typeof F === "number" && c.p.colModel[F + E + x + u] != null && (C = a.jgrid.getAccessor(g, c.p.colModel[F + E + x + u].name));
                                                if (C === void 0) {
                                                    C = I + m;
                                                    if (y.length === 0 && d.cell) {
                                                        e = a.jgrid.getAccessor(g, d.cell) ||
                                                            g;
                                                        C = e != null && e[F] !== void 0 ? e[F] : C
                                                    }
                                                }
                                            }
                                            if (g) {
                                                C = c.p.idPrefix + C;
                                                z = j;
                                                if (d.repeatitems) {
                                                    d.cell && (g = a.jgrid.getAccessor(g, d.cell) || g);
                                                    a.isArray(g) && (z = D)
                                                }
                                                for (p = 0; p < z.length; p++) G[c.p.colModel[p + E + x + u].name] = a.jgrid.getAccessor(g, z[p]);
                                                G._id_ = a.jgrid.stripPref(c.p.idPrefix, C);
                                                c.p.grouping && N.call(l, G, m);
                                                c.p.data.push(G);
                                                c.p._index[G._id_] = c.p.data.length - 1;
                                                G = {}
                                            }
                                            m++
                                        }
                                        if (c.p.grouping) {
                                            c.p.groupingView._locgr = true;
                                            l.jqGrid("groupingRender", S, c.p.colModel.length, c.p.page, M)
                                        }
                                    }
                                }
                            },
                            z = function() {
                                function b(a) {
                                    var c =
                                        0,
                                        d, e, f, i, j;
                                    if (a.groups != null) {
                                        (e = a.groups.length && a.groupOp.toString().toUpperCase() === "OR") && p.orBegin();
                                        for (d = 0; d < a.groups.length; d++) {
                                            c > 0 && e && p.or();
                                            try {
                                                b(a.groups[d])
                                            } catch (h) {
                                                alert(h)
                                            }
                                            c++
                                        }
                                        e && p.orEnd()
                                    }
                                    if (a.rules != null) try {
                                        (f = a.rules.length && a.groupOp.toString().toUpperCase() === "OR") && p.orBegin();
                                        for (d = 0; d < a.rules.length; d++) {
                                            j = a.rules[d];
                                            i = a.groupOp.toString().toUpperCase();
                                            if (r[j.op] && j.field) {
                                                c > 0 && (i && i === "OR") && (p = p.or());
                                                p = r[j.op](p, i)(j.field, j.data, g[j.field])
                                            }
                                            c++
                                        }
                                        f && p.orEnd()
                                    } catch (l) {
                                        alert(l)
                                    }
                                }
                                var d = c.p.multiSort ? [] : "",
                                    e = [],
                                    f = false,
                                    g = {},
                                    i = [],
                                    j = [],
                                    h, l, m;
                                if (a.isArray(c.p.data)) {
                                    var k = c.p.grouping ? c.p.groupingView : false,
                                        n, o;
                                    a.each(c.p.colModel, function() {
                                        l = this.sorttype || "text";
                                        if (l === "date" || l === "datetime") {
                                            if (this.formatter && typeof this.formatter === "string" && this.formatter === "date") {
                                                h = this.formatoptions && this.formatoptions.srcformat ? this.formatoptions.srcformat : a.jgrid.formatter.date.srcformat;
                                                m = this.formatoptions && this.formatoptions.newformat ? this.formatoptions.newformat : a.jgrid.formatter.date.newformat
                                            } else h =
                                                m = this.datefmt || "Y-m-d";
                                            g[this.name] = {
                                                stype: l,
                                                srcfmt: h,
                                                newfmt: m,
                                                sfunc: this.sortfunc || null
                                            }
                                        } else g[this.name] = {
                                            stype: l,
                                            srcfmt: "",
                                            newfmt: "",
                                            sfunc: this.sortfunc || null
                                        }; if (c.p.grouping) {
                                            o = 0;
                                            for (n = k.groupField.length; o < n; o++)
                                                if (this.name === k.groupField[o]) {
                                                    var b = this.name;
                                                    if (this.index) b = this.index;
                                                    i[o] = g[b];
                                                    j[o] = b
                                                }
                                        }
                                        if (c.p.multiSort) {
                                            if (this.lso) {
                                                d.push(this.name);
                                                b = this.lso.split("-");
                                                e.push(b[b.length - 1])
                                            }
                                        } else if (!f && (this.index === c.p.sortname || this.name === c.p.sortname)) {
                                            d = this.name;
                                            f = true
                                        }
                                    });
                                    if (c.p.treeGrid) a(c).jqGrid("SortTree",
                                        d, c.p.sortorder, g[d].stype || "text", g[d].srcfmt || "");
                                    else {
                                        var r = {
                                                eq: function(a) {
                                                    return a.equals
                                                },
                                                ne: function(a) {
                                                    return a.notEquals
                                                },
                                                lt: function(a) {
                                                    return a.less
                                                },
                                                le: function(a) {
                                                    return a.lessOrEquals
                                                },
                                                gt: function(a) {
                                                    return a.greater
                                                },
                                                ge: function(a) {
                                                    return a.greaterOrEquals
                                                },
                                                cn: function(a) {
                                                    return a.contains
                                                },
                                                nc: function(a, c) {
                                                    return c === "OR" ? a.orNot().contains : a.andNot().contains
                                                },
                                                bw: function(a) {
                                                    return a.startsWith
                                                },
                                                bn: function(a, c) {
                                                    return c === "OR" ? a.orNot().startsWith : a.andNot().startsWith
                                                },
                                                en: function(a,
                                                    c) {
                                                    return c === "OR" ? a.orNot().endsWith : a.andNot().endsWith
                                                },
                                                ew: function(a) {
                                                    return a.endsWith
                                                },
                                                ni: function(a, c) {
                                                    return c === "OR" ? a.orNot().equals : a.andNot().equals
                                                },
                                                "in": function(a) {
                                                    return a.equals
                                                },
                                                nu: function(a) {
                                                    return a.isNull
                                                },
                                                nn: function(a, c) {
                                                    return c === "OR" ? a.orNot().isNull : a.andNot().isNull
                                                }
                                            },
                                            p = a.jgrid.from(c.p.data);
                                        c.p.ignoreCase && (p = p.ignoreCase());
                                        if (c.p.search === true) {
                                            var q = c.p.postData.filters;
                                            if (q) {
                                                typeof q === "string" && (q = a.jgrid.parse(q));
                                                b(q)
                                            } else try {
                                                p = r[c.p.postData.searchOper](p)(c.p.postData.searchField,
                                                    c.p.postData.searchString, g[c.p.postData.searchField])
                                            } catch (s) {}
                                        }
                                        if (c.p.grouping)
                                            for (o = 0; o < n; o++) p.orderBy(j[o], k.groupOrder[o], i[o].stype, i[o].srcfmt);
                                        c.p.multiSort ? a.each(d, function(a) {
                                            p.orderBy(this, e[a], g[this].stype, g[this].srcfmt, g[this].sfunc)
                                        }) : d && (c.p.sortorder && f) && (c.p.sortorder.toUpperCase() === "DESC" ? p.orderBy(c.p.sortname, "d", g[d].stype, g[d].srcfmt, g[d].sfunc) : p.orderBy(c.p.sortname, "a", g[d].stype, g[d].srcfmt, g[d].sfunc));
                                        var q = p.select(),
                                            y = parseInt(c.p.rowNum, 10),
                                            t = q.length,
                                            v = parseInt(c.p.page,
                                                10),
                                            w = Math.ceil(t / y),
                                            E = {};
                                        if ((c.p.search || c.p.resetsearch) && c.p.grouping && c.p.groupingView._locgr) {
                                            c.p.groupingView.groups = [];
                                            var x, u = a.jgrid.getMethod("groupingPrepare"),
                                                K, D;
                                            if (c.p.footerrow && c.p.userDataOnFooter) {
                                                for (K in c.p.userData) c.p.userData.hasOwnProperty(K) && (c.p.userData[K] = 0);
                                                D = true
                                            }
                                            for (x = 0; x < t; x++) {
                                                if (D)
                                                    for (K in c.p.userData) c.p.userData[K] = c.p.userData[K] + parseFloat(q[x][K] || 0);
                                                u.call(a(c), q[x], x, y)
                                            }
                                        }
                                        q = q.slice((v - 1) * y, v * y);
                                        g = p = null;
                                        E[c.p.localReader.total] = w;
                                        E[c.p.localReader.page] =
                                            v;
                                        E[c.p.localReader.records] = t;
                                        E[c.p.localReader.root] = q;
                                        E[c.p.localReader.userdata] = c.p.userData;
                                        q = null;
                                        return E
                                    }
                                }
                            },
                            u = function() {
                                c.grid.hDiv.loading = true;
                                if (!c.p.hiddengrid) switch (c.p.loadui) {
                                    case "enable":
                                        a("#load_" + a.jgrid.jqID(c.p.id)).show();
                                        break;
                                    case "block":
                                        a("#lui_" + a.jgrid.jqID(c.p.id)).show();
                                        a("#load_" + a.jgrid.jqID(c.p.id)).show()
                                }
                            },
                            A = function() {
                                c.grid.hDiv.loading = false;
                                switch (c.p.loadui) {
                                    case "enable":
                                        a("#load_" + a.jgrid.jqID(c.p.id)).hide();
                                        break;
                                    case "block":
                                        a("#lui_" + a.jgrid.jqID(c.p.id)).hide();
                                        a("#load_" + a.jgrid.jqID(c.p.id)).hide()
                                }
                            },
                            B = function(b) {
                                if (!c.grid.hDiv.loading) {
                                    var d = c.p.scroll && b === false,
                                        e = {},
                                        f, g = c.p.prmNames;
                                    if (c.p.page <= 0) c.p.page = Math.min(1, c.p.lastpage);
                                    if (g.search !== null) e[g.search] = c.p.search;
                                    g.nd !== null && (e[g.nd] = (new Date).getTime());
                                    if (g.rows !== null) e[g.rows] = c.p.rowNum;
                                    if (g.page !== null) e[g.page] = c.p.page;
                                    if (g.sort !== null) e[g.sort] = c.p.sortname;
                                    if (g.order !== null) e[g.order] = c.p.sortorder;
                                    if (c.p.rowTotal !== null && g.totalrows !== null) e[g.totalrows] = c.p.rowTotal;
                                    var i = a.isFunction(c.p.loadComplete),
                                        j = i ? c.p.loadComplete : null,
                                        h = 0,
                                        b = b || 1;
                                    if (b > 1)
                                        if (g.npage !== null) {
                                            e[g.npage] = b;
                                            h = b - 1;
                                            b = 1
                                        } else j = function(a) {
                                            c.p.page++;
                                            c.grid.hDiv.loading = false;
                                            i && c.p.loadComplete.call(c, a);
                                            B(b - 1)
                                        };
                                    else g.npage !== null && delete c.p.postData[g.npage]; if (c.p.grouping) {
                                        a(c).jqGrid("groupingSetup");
                                        var l = c.p.groupingView,
                                            m, k = "";
                                        for (m = 0; m < l.groupField.length; m++) {
                                            var n = l.groupField[m];
                                            a.each(c.p.colModel, function(a, c) {
                                                if (c.name === n && c.index) n = c.index
                                            });
                                            k = k + (n + " " + l.groupOrder[m] + ", ")
                                        }
                                        e[g.sort] = k + e[g.sort]
                                    }
                                    a.extend(c.p.postData,
                                        e);
                                    var o = !c.p.scroll ? 1 : c.rows.length - 1,
                                        e = a(c).triggerHandler("jqGridBeforeRequest");
                                    if (!(e === false || e === "stop"))
                                        if (a.isFunction(c.p.datatype)) c.p.datatype.call(c, c.p.postData, "load_" + c.p.id, o, b, h);
                                        else {
                                            if (a.isFunction(c.p.beforeRequest)) {
                                                e = c.p.beforeRequest.call(c);
                                                e === void 0 && (e = true);
                                                if (e === false) return
                                            }
                                            f = c.p.datatype.toLowerCase();
                                            switch (f) {
                                                case "json":
                                                case "jsonp":
                                                case "xml":
                                                case "script":
                                                    a.ajax(a.extend({
                                                        url: c.p.url,
                                                        type: c.p.mtype,
                                                        dataType: f,
                                                        data: a.isFunction(c.p.serializeGridData) ? c.p.serializeGridData.call(c,
                                                            c.p.postData) : c.p.postData,
                                                        success: function(e, g, i) {
                                                            if (a.isFunction(c.p.beforeProcessing) && c.p.beforeProcessing.call(c, e, g, i) === false) A();
                                                            else {
                                                                f === "xml" ? y(e, c.grid.bDiv, o, b > 1, h) : D(e, c.grid.bDiv, o, b > 1, h);
                                                                a(c).triggerHandler("jqGridLoadComplete", [e]);
                                                                j && j.call(c, e);
                                                                a(c).triggerHandler("jqGridAfterLoadComplete", [e]);
                                                                d && c.grid.populateVisible();
                                                                if (c.p.loadonce || c.p.treeGrid) c.p.datatype = "local";
                                                                b === 1 && A()
                                                            }
                                                        },
                                                        error: function(d, e, f) {
                                                            a.isFunction(c.p.loadError) && c.p.loadError.call(c, d, e, f);
                                                            b === 1 && A()
                                                        },
                                                        beforeSend: function(b,
                                                            d) {
                                                            var e = true;
                                                            a.isFunction(c.p.loadBeforeSend) && (e = c.p.loadBeforeSend.call(c, b, d));
                                                            e === void 0 && (e = true);
                                                            if (e === false) return false;
                                                            u()
                                                        }
                                                    }, a.jgrid.ajaxOptions, c.p.ajaxGridOptions));
                                                    break;
                                                case "xmlstring":
                                                    u();
                                                    e = typeof c.p.datastr !== "string" ? c.p.datastr : a.parseXML(c.p.datastr);
                                                    y(e, c.grid.bDiv);
                                                    a(c).triggerHandler("jqGridLoadComplete", [e]);
                                                    i && c.p.loadComplete.call(c, e);
                                                    a(c).triggerHandler("jqGridAfterLoadComplete", [e]);
                                                    c.p.datatype = "local";
                                                    c.p.datastr = null;
                                                    A();
                                                    break;
                                                case "jsonstring":
                                                    u();
                                                    e = typeof c.p.datastr ===
                                                        "string" ? a.jgrid.parse(c.p.datastr) : c.p.datastr;
                                                    D(e, c.grid.bDiv);
                                                    a(c).triggerHandler("jqGridLoadComplete", [e]);
                                                    i && c.p.loadComplete.call(c, e);
                                                    a(c).triggerHandler("jqGridAfterLoadComplete", [e]);
                                                    c.p.datatype = "local";
                                                    c.p.datastr = null;
                                                    A();
                                                    break;
                                                case "local":
                                                case "clientside":
                                                    u();
                                                    c.p.datatype = "local";
                                                    e = z();
                                                    D(e, c.grid.bDiv, o, b > 1, h);
                                                    a(c).triggerHandler("jqGridLoadComplete", [e]);
                                                    j && j.call(c, e);
                                                    a(c).triggerHandler("jqGridAfterLoadComplete", [e]);
                                                    d && c.grid.populateVisible();
                                                    A()
                                            }
                                        }
                                }
                            },
                            O = function(b) {
                                a("#cb_" + a.jgrid.jqID(c.p.id),
                                    c.grid.hDiv)[c.p.useProp ? "prop" : "attr"]("checked", b);
                                if (c.p.frozenColumns && c.p.id + "_frozen") a("#cb_" + a.jgrid.jqID(c.p.id), c.grid.fhDiv)[c.p.useProp ? "prop" : "attr"]("checked", b)
                            },
                            N = function(b, d) {
                                var e = "",
                                    f = "<table cellspacing='0' cellpadding='0' border='0' style='table-layout:auto;' class='ui-pg-table'><tbody><tr>",
                                    g = "",
                                    j, h, l, m, k = function(b) {
                                        var d;
                                        a.isFunction(c.p.onPaging) && (d = c.p.onPaging.call(c, b));
                                        if (d === "stop") return false;
                                        c.p.selrow = null;
                                        if (c.p.multiselect) {
                                            c.p.selarrrow = [];
                                            O(false)
                                        }
                                        c.p.savedRow = [];
                                        return true
                                    },
                                    b = b.substr(1),
                                    d = d + ("_" + b);
                                j = "pg_" + b;
                                h = b + "_left";
                                l = b + "_center";
                                m = b + "_right";
                                a("#" + a.jgrid.jqID(b)).append("<div id='" + j + "' class='ui-pager-control' role='group'><table cellspacing='0' cellpadding='0' border='0' class='ui-pg-table' style='width:100%;table-layout:fixed;height:100%;' role='row'><tbody><tr><td id='" + h + "' align='left'></td><td id='" + l + "' align='center' style='white-space:pre;'></td><td id='" + m + "' align='right'></td></tr></tbody></table></div>").attr("dir", "ltr");
                                if (c.p.rowList.length >
                                    0) {
                                    g = "<td dir='" + i + "'>";
                                    g = g + "<select class='ui-pg-selbox' role='listbox'>";
                                    for (h = 0; h < c.p.rowList.length; h++) {
                                        l = c.p.rowList[h].toString().split(":");
                                        l.length === 1 && (l[1] = l[0]);
                                        g = g + ('<option role="option" value="' + l[0] + '"' + (o(c.p.rowNum, 0) === o(l[0], 0) ? ' selected="selected"' : "") + ">" + l[1] + "</option>")
                                    }
                                    g = g + "</select></td>"
                                }
                                i === "rtl" && (f = f + g);
                                c.p.pginput === true && (e = "<td dir='" + i + "'>" + a.jgrid.format(c.p.pgtext || "", "<input class='ui-pg-input' type='text' size='2' maxlength='7' value='0' role='textbox'/>",
                                    "<span id='sp_1_" + a.jgrid.jqID(b) + "'></span>") + "</td>");
                                if (c.p.pgbuttons === true) {
                                    h = ["first" + d, "prev" + d, "next" + d, "last" + d];
                                    i === "rtl" && h.reverse();
                                    f = f + ("<td id='" + h[0] + "' class='ui-pg-button ui-corner-all'><span class='ui-icon ui-icon-seek-first'></span></td>");
                                    f = f + ("<td id='" + h[1] + "' class='ui-pg-button ui-corner-all'><span class='ui-icon ui-icon-seek-prev'></span></td>");
                                    f = f + (e !== "" ? "<td class='ui-pg-button ui-state-disabled' style='width:4px;'><span class='ui-separator'></span></td>" + e + "<td class='ui-pg-button ui-state-disabled' style='width:4px;'><span class='ui-separator'></span></td>" :
                                        "") + ("<td id='" + h[2] + "' class='ui-pg-button ui-corner-all'><span class='ui-icon ui-icon-seek-next'></span></td>");
                                    f = f + ("<td id='" + h[3] + "' class='ui-pg-button ui-corner-all'><span class='ui-icon ui-icon-seek-end'></span></td>")
                                } else e !== "" && (f = f + e);
                                i === "ltr" && (f = f + g);
                                f = f + "</tr></tbody></table>";
                                c.p.viewrecords === true && a("td#" + b + "_" + c.p.recordpos, "#" + j).append("<div dir='" + i + "' style='text-align:" + c.p.recordpos + "' class='ui-paging-info'></div>");
                                a("td#" + b + "_" + c.p.pagerpos, "#" + j).append(f);
                                g = a(".ui-jqgrid").css("font-size") ||
                                    "11px";
                                a(document.body).append("<div id='testpg' class='ui-jqgrid ui-widget ui-widget-content' style='font-size:" + g + ";visibility:hidden;' ></div>");
                                f = a(f).clone().appendTo("#testpg").width();
                                a("#testpg").remove();
                                if (f > 0) {
                                    e !== "" && (f = f + 50);
                                    a("td#" + b + "_" + c.p.pagerpos, "#" + j).width(f)
                                }
                                c.p._nvtd = [];
                                c.p._nvtd[0] = f ? Math.floor((c.p.width - f) / 2) : Math.floor(c.p.width / 3);
                                c.p._nvtd[1] = 0;
                                f = null;
                                a(".ui-pg-selbox", "#" + j).bind("change", function() {
                                    if (!k("records")) return false;
                                    c.p.page = Math.round(c.p.rowNum * (c.p.page -
                                        1) / this.value - 0.5) + 1;
                                    c.p.rowNum = this.value;
                                    c.p.pager && a(".ui-pg-selbox", c.p.pager).val(this.value);
                                    c.p.toppager && a(".ui-pg-selbox", c.p.toppager).val(this.value);
                                    B();
                                    return false
                                });
                                if (c.p.pgbuttons === true) {
                                    a(".ui-pg-button", "#" + j).hover(function() {
                                        if (a(this).hasClass("ui-state-disabled")) this.style.cursor = "default";
                                        else {
                                            a(this).addClass("ui-state-hover");
                                            this.style.cursor = "pointer"
                                        }
                                    }, function() {
                                        if (!a(this).hasClass("ui-state-disabled")) {
                                            a(this).removeClass("ui-state-hover");
                                            this.style.cursor = "default"
                                        }
                                    });
                                    a("#first" + a.jgrid.jqID(d) + ", #prev" + a.jgrid.jqID(d) + ", #next" + a.jgrid.jqID(d) + ", #last" + a.jgrid.jqID(d)).click(function() {
                                        if (a(this).hasClass("ui-state-disabled")) return false;
                                        var b = o(c.p.page, 1),
                                            e = o(c.p.lastpage, 1),
                                            f = false,
                                            g = true,
                                            i = true,
                                            j = true,
                                            h = true;
                                        if (e === 0 || e === 1) h = j = i = g = false;
                                        else if (e > 1 && b >= 1)
                                            if (b === 1) i = g = false;
                                            else {
                                                if (b === e) h = j = false
                                            } else if (e > 1 && b === 0) {
                                            h = j = false;
                                            b = e - 1
                                        }
                                        if (!k(this.id)) return false;
                                        if (this.id === "first" + d && g) {
                                            c.p.page = 1;
                                            f = true
                                        }
                                        if (this.id === "prev" + d && i) {
                                            c.p.page = b - 1;
                                            f = true
                                        }
                                        if (this.id ===
                                            "next" + d && j) {
                                            c.p.page = b + 1;
                                            f = true
                                        }
                                        if (this.id === "last" + d && h) {
                                            c.p.page = e;
                                            f = true
                                        }
                                        f && B();
                                        return false
                                    })
                                }
                                c.p.pginput === true && a("input.ui-pg-input", "#" + j).keypress(function(b) {
                                    if ((b.charCode || b.keyCode || 0) === 13) {
                                        if (!k("user")) return false;
                                        a(this).val(o(a(this).val(), 1));
                                        c.p.page = a(this).val() > 0 ? a(this).val() : c.p.page;
                                        B();
                                        return false
                                    }
                                    return this
                                })
                            },
                            U = function(b, d) {
                                var e, f = "",
                                    g = c.p.colModel,
                                    i = false,
                                    j;
                                j = c.p.frozenColumns ? d : c.grid.headers[b].el;
                                var h = "";
                                a("span.ui-grid-ico-sort", j).addClass("ui-state-disabled");
                                a(j).attr("aria-selected", "false");
                                if (g[b].lso)
                                    if (g[b].lso === "asc") {
                                        g[b].lso = g[b].lso + "-desc";
                                        h = "desc"
                                    } else if (g[b].lso === "desc") {
                                    g[b].lso = g[b].lso + "-asc";
                                    h = "asc"
                                } else {
                                    if (g[b].lso === "asc-desc" || g[b].lso === "desc-asc") g[b].lso = ""
                                } else g[b].lso = h = g[b].firstsortorder || "asc"; if (h) {
                                    a("span.s-ico", j).show();
                                    a("span.ui-icon-" + h, j).removeClass("ui-state-disabled");
                                    a(j).attr("aria-selected", "true")
                                } else c.p.viewsortcols[0] || a("span.s-ico", j).hide();
                                c.p.sortorder = "";
                                a.each(g, function(a) {
                                    if (this.lso) {
                                        a > 0 && i &&
                                            (f = f + ", ");
                                        e = this.lso.split("-");
                                        f = f + (g[a].index || g[a].name);
                                        f = f + (" " + e[e.length - 1]);
                                        i = true;
                                        c.p.sortorder = e[e.length - 1]
                                    }
                                });
                                j = f.lastIndexOf(c.p.sortorder);
                                f = f.substring(0, j);
                                c.p.sortname = f
                            },
                            F = function(b, d, e, f, g) {
                                if (c.p.colModel[d].sortable && !(c.p.savedRow.length > 0)) {
                                    if (!e) {
                                        if (c.p.lastsort === d)
                                            if (c.p.sortorder === "asc") c.p.sortorder = "desc";
                                            else {
                                                if (c.p.sortorder === "desc") c.p.sortorder = "asc"
                                            } else c.p.sortorder = c.p.colModel[d].firstsortorder || "asc";
                                        c.p.page = 1
                                    }
                                    if (c.p.multiSort) U(d, g);
                                    else {
                                        if (f) {
                                            if (c.p.lastsort ===
                                                d && c.p.sortorder === f && !e) return;
                                            c.p.sortorder = f
                                        }
                                        e = c.grid.headers[c.p.lastsort].el;
                                        g = c.p.frozenColumns ? g : c.grid.headers[d].el;
                                        a("span.ui-grid-ico-sort", e).addClass("ui-state-disabled");
                                        a(e).attr("aria-selected", "false");
                                        if (c.p.frozenColumns) {
                                            c.grid.fhDiv.find("span.ui-grid-ico-sort").addClass("ui-state-disabled");
                                            c.grid.fhDiv.find("th").attr("aria-selected", "false")
                                        }
                                        a("span.ui-icon-" + c.p.sortorder, g).removeClass("ui-state-disabled");
                                        a(g).attr("aria-selected", "true");
                                        if (!c.p.viewsortcols[0] && c.p.lastsort !==
                                            d) {
                                            c.p.frozenColumns && c.grid.fhDiv.find("span.s-ico").hide();
                                            a("span.s-ico", e).hide();
                                            a("span.s-ico", g).show()
                                        }
                                        b = b.substring(5 + c.p.id.length + 1);
                                        c.p.sortname = c.p.colModel[d].index || b
                                    } if (a(c).triggerHandler("jqGridSortCol", [c.p.sortname, d, c.p.sortorder]) === "stop") c.p.lastsort = d;
                                    else if (a.isFunction(c.p.onSortCol) && c.p.onSortCol.call(c, c.p.sortname, d, c.p.sortorder) === "stop") c.p.lastsort = d;
                                    else {
                                        if (c.p.datatype === "local") c.p.deselectAfterSort && a(c).jqGrid("resetSelection");
                                        else {
                                            c.p.selrow = null;
                                            c.p.multiselect &&
                                                O(false);
                                            c.p.selarrrow = [];
                                            c.p.savedRow = []
                                        } if (c.p.scroll) {
                                            g = c.grid.bDiv.scrollLeft;
                                            v.call(c, true, false);
                                            c.grid.hDiv.scrollLeft = g
                                        }
                                        c.p.subGrid && c.p.datatype === "local" && a("td.sgexpanded", "#" + a.jgrid.jqID(c.p.id)).each(function() {
                                            a(this).trigger("click")
                                        });
                                        B();
                                        c.p.lastsort = d;
                                        if (c.p.sortname !== b && d) c.p.lastsort = d
                                    }
                                }
                            },
                            Y = function(b) {
                                b = a(c.grid.headers[b].el);
                                b = [b.position().left + b.outerWidth()];
                                c.p.direction === "rtl" && (b[0] = c.p.width - b[0]);
                                b[0] = b[0] - c.grid.bDiv.scrollLeft;
                                b.push(a(c.grid.hDiv).position().top);
                                b.push(a(c.grid.bDiv).offset().top - a(c.grid.hDiv).offset().top + a(c.grid.bDiv).height());
                                return b
                            },
                            R = function(b) {
                                var d, e = c.grid.headers,
                                    f = a.jgrid.getCellIndex(b);
                                for (d = 0; d < e.length; d++)
                                    if (b === e[d].el) {
                                        f = d;
                                        break
                                    }
                                return f
                            };
                        this.p.id = this.id; - 1 === a.inArray(c.p.multikey, ["shiftKey", "altKey", "ctrlKey"]) && (c.p.multikey = !1);
                        c.p.keyName = !1;
                        for (g = 0; g < c.p.colModel.length; g++) c.p.colModel[g] = a.extend(!0, {}, c.p.cmTemplate, c.p.colModel[g].template || {}, c.p.colModel[g]), !1 === c.p.keyName && !0 === c.p.colModel[g].key &&
                            (c.p.keyName = c.p.colModel[g].name);
                        c.p.sortorder = c.p.sortorder.toLowerCase();
                        a.jgrid.cell_width = a.jgrid.cellWidth();
                        !0 === c.p.grouping && (c.p.scroll = !1, c.p.rownumbers = !1, c.p.treeGrid = !1, c.p.gridview = !0);
                        if (!0 === this.p.treeGrid) {
                            try {
                                a(this).jqGrid("setTreeGrid")
                            } catch (Z) {}
                            "local" !== c.p.datatype && (c.p.localReader = {
                                id: "_id_"
                            })
                        }
                        if (this.p.subGrid) try {
                            a(c).jqGrid("setSubGrid")
                        } catch (ca) {}
                        this.p.multiselect && (this.p.colNames.unshift("<input role='checkbox' id='cb_" + this.p.id + "' class='cbox' type='checkbox'/>"),
                            this.p.colModel.unshift({
                                name: "cb",
                                width: a.jgrid.cell_width ? c.p.multiselectWidth + c.p.cellLayout : c.p.multiselectWidth,
                                sortable: !1,
                                resizable: !1,
                                hidedlg: !0,
                                search: !1,
                                align: "center",
                                fixed: !0
                            }));
                        this.p.rownumbers && (this.p.colNames.unshift(""), this.p.colModel.unshift({
                            name: "rn",
                            width: c.p.rownumWidth,
                            sortable: !1,
                            resizable: !1,
                            hidedlg: !0,
                            search: !1,
                            align: "center",
                            fixed: !0
                        }));
                        c.p.xmlReader = a.extend(!0, {
                            root: "rows",
                            row: "row",
                            page: "rows>page",
                            total: "rows>total",
                            records: "rows>records",
                            repeatitems: !0,
                            cell: "cell",
                            id: "[id]",
                            userdata: "userdata",
                            subgrid: {
                                root: "rows",
                                row: "row",
                                repeatitems: !0,
                                cell: "cell"
                            }
                        }, c.p.xmlReader);
                        c.p.jsonReader = a.extend(!0, {
                            root: "rows",
                            page: "page",
                            total: "total",
                            records: "records",
                            repeatitems: !0,
                            cell: "cell",
                            id: "id",
                            userdata: "userdata",
                            subgrid: {
                                root: "rows",
                                repeatitems: !0,
                                cell: "cell"
                            }
                        }, c.p.jsonReader);
                        c.p.localReader = a.extend(!0, {
                            root: "rows",
                            page: "page",
                            total: "total",
                            records: "records",
                            repeatitems: !1,
                            cell: "cell",
                            id: "id",
                            userdata: "userdata",
                            subgrid: {
                                root: "rows",
                                repeatitems: !0,
                                cell: "cell"
                            }
                        }, c.p.localReader);
                        c.p.scroll && (c.p.pgbuttons = !1, c.p.pginput = !1, c.p.rowList = []);
                        c.p.data.length && x();
                        var E = "<thead><tr class='ui-jqgrid-labels' role='rowheader'>",
                            K, L, C, V, J, M, I, G, fa = G = "",
                            Q = [],
                            ga = [];
                        L = [];
                        if (!0 === c.p.shrinkToFit && !0 === c.p.forceFit)
                            for (g = c.p.colModel.length - 1; 0 <= g; g--)
                                if (!c.p.colModel[g].hidden) {
                                    c.p.colModel[g].resizable = !1;
                                    break
                                }
                                "horizontal" === c.p.viewsortcols[1] && (G = " ui-i-asc", fa = " ui-i-desc");
                        K = k ? "class='ui-th-div-ie'" : "";
                        G = "<span class='s-ico' style='display:none'><span sort='asc' class='ui-grid-ico-sort ui-icon-asc" +
                            G + " ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-" + i + "'></span>" + ("<span sort='desc' class='ui-grid-ico-sort ui-icon-desc" + fa + " ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-" + i + "'></span></span>");
                        if (c.p.multiSort) {
                            Q = c.p.sortname.split(",");
                            for (g = 0; g < Q.length; g++) L = a.trim(Q[g]).split(" "), Q[g] = a.trim(L[0]), ga[g] = L[1] ? a.trim(L[1]) : c.p.sortorder || "asc"
                        }
                        for (g = 0; g < this.p.colNames.length; g++) L = c.p.headertitles ? ' title="' + a.jgrid.stripHtml(c.p.colNames[g]) + '"' : "", E += "<th id='" + c.p.id +
                            "_" + c.p.colModel[g].name + "' role='columnheader' class='ui-state-default ui-th-column ui-th-" + i + "'" + L + ">", L = c.p.colModel[g].index || c.p.colModel[g].name, E += "<div id='jqgh_" + c.p.id + "_" + c.p.colModel[g].name + "' " + K + ">" + c.p.colNames[g], c.p.colModel[g].width = c.p.colModel[g].width ? parseInt(c.p.colModel[g].width, 10) : 150, "boolean" !== typeof c.p.colModel[g].title && (c.p.colModel[g].title = !0), c.p.colModel[g].lso = "", L === c.p.sortname && (c.p.lastsort = g), c.p.multiSort && (L = a.inArray(L, Q), -1 !== L && (c.p.colModel[g].lso =
                                ga[L])), E += G + "</div></th>";
                        G = null;
                        a(this).append(E + "</tr></thead>");
                        a("thead tr:first th", this).hover(function() {
                            a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        });
                        if (this.p.multiselect) {
                            var S = [],
                                $;
                            a("#cb_" + a.jgrid.jqID(c.p.id), this).bind("click", function() {
                                c.p.selarrrow = [];
                                var b = c.p.frozenColumns === true ? c.p.id + "_frozen" : "";
                                if (this.checked) {
                                    a(c.rows).each(function(d) {
                                        if (d > 0 && !a(this).hasClass("ui-subgrid") && !a(this).hasClass("jqgroup") && !a(this).hasClass("ui-state-disabled")) {
                                            a("#jqg_" +
                                                a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(this.id))[c.p.useProp ? "prop" : "attr"]("checked", true);
                                            a(this).addClass("ui-state-highlight").attr("aria-selected", "true");
                                            c.p.selarrrow.push(this.id);
                                            c.p.selrow = this.id;
                                            if (b) {
                                                a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(this.id), c.grid.fbDiv)[c.p.useProp ? "prop" : "attr"]("checked", true);
                                                a("#" + a.jgrid.jqID(this.id), c.grid.fbDiv).addClass("ui-state-highlight")
                                            }
                                        }
                                    });
                                    $ = true;
                                    S = []
                                } else {
                                    a(c.rows).each(function(d) {
                                        if (d > 0 && !a(this).hasClass("ui-subgrid") && !a(this).hasClass("ui-state-disabled")) {
                                            a("#jqg_" +
                                                a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(this.id))[c.p.useProp ? "prop" : "attr"]("checked", false);
                                            a(this).removeClass("ui-state-highlight").attr("aria-selected", "false");
                                            S.push(this.id);
                                            if (b) {
                                                a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(this.id), c.grid.fbDiv)[c.p.useProp ? "prop" : "attr"]("checked", false);
                                                a("#" + a.jgrid.jqID(this.id), c.grid.fbDiv).removeClass("ui-state-highlight")
                                            }
                                        }
                                    });
                                    c.p.selrow = null;
                                    $ = false
                                }
                                a(c).triggerHandler("jqGridSelectAll", [$ ? c.p.selarrrow : S, $]);
                                a.isFunction(c.p.onSelectAll) && c.p.onSelectAll.call(c,
                                    $ ? c.p.selarrrow : S, $)
                            })
                        }!0 === c.p.autowidth && (E = a(m).innerWidth(), c.p.width = 0 < E ? E : "nw");
                        (function() {
                            var b = 0,
                                d = a.jgrid.cell_width ? 0 : o(c.p.cellLayout, 0),
                                f = 0,
                                g, i = o(c.p.scrollOffset, 0),
                                j, l = false,
                                m, k = 0,
                                n;
                            a.each(c.p.colModel, function() {
                                if (this.hidden === void 0) this.hidden = false;
                                if (c.p.grouping && c.p.autowidth) {
                                    var e = a.inArray(this.name, c.p.groupingView.groupField);
                                    if (e >= 0 && c.p.groupingView.groupColumnShow.length > e) this.hidden = !c.p.groupingView.groupColumnShow[e]
                                }
                                this.widthOrg = j = o(this.width, 0);
                                if (this.hidden ===
                                    false) {
                                    b = b + (j + d);
                                    this.fixed ? k = k + (j + d) : f++
                                }
                            });
                            if (isNaN(c.p.width)) c.p.width = b + (c.p.shrinkToFit === false && !isNaN(c.p.height) ? i : 0);
                            e.width = c.p.width;
                            c.p.tblwidth = b;
                            if (c.p.shrinkToFit === false && c.p.forceFit === true) c.p.forceFit = false;
                            if (c.p.shrinkToFit === true && f > 0) {
                                m = e.width - d * f - k;
                                if (!isNaN(c.p.height)) {
                                    m = m - i;
                                    l = true
                                }
                                b = 0;
                                a.each(c.p.colModel, function(a) {
                                    if (this.hidden === false && !this.fixed) {
                                        this.width = j = Math.round(m * this.width / (c.p.tblwidth - d * f - k));
                                        b = b + j;
                                        g = a
                                    }
                                });
                                n = 0;
                                l ? e.width - k - (b + d * f) !== i && (n = e.width - k - (b +
                                    d * f) - i) : !l && Math.abs(e.width - k - (b + d * f)) !== 1 && (n = e.width - k - (b + d * f));
                                c.p.colModel[g].width = c.p.colModel[g].width + n;
                                c.p.tblwidth = b + n + d * f + k;
                                if (c.p.tblwidth > c.p.width) {
                                    c.p.colModel[g].width = c.p.colModel[g].width - (c.p.tblwidth - parseInt(c.p.width, 10));
                                    c.p.tblwidth = c.p.width
                                }
                            }
                        })();
                        a(m).css("width", e.width + "px").append("<div class='ui-jqgrid-resize-mark' id='rs_m" + c.p.id + "'>&#160;</div>");
                        a(j).css("width", e.width + "px");
                        var E = a("thead:first", c).get(0),
                            W = "";
                        c.p.footerrow && (W += "<table role='grid' style='width:" +
                            c.p.tblwidth + "px' class='ui-jqgrid-ftable' cellspacing='0' cellpadding='0' border='0'><tbody><tr role='row' class='ui-widget-content footrow footrow-" + i + "'>");
                        var j = a("tr:first", E),
                            aa = "<tr class='jqgfirstrow' role='row' style='height:auto'>";
                        c.p.disableClick = !1;
                        a("th", j).each(function(b) {
                            C = c.p.colModel[b].width;
                            if (c.p.colModel[b].resizable === void 0) c.p.colModel[b].resizable = true;
                            if (c.p.colModel[b].resizable) {
                                V = document.createElement("span");
                                a(V).html("&#160;").addClass("ui-jqgrid-resize ui-jqgrid-resize-" +
                                    i).css("cursor", "col-resize");
                                a(this).addClass(c.p.resizeclass)
                            } else V = "";
                            a(this).css("width", C + "px").prepend(V);
                            V = null;
                            var d = "";
                            if (c.p.colModel[b].hidden) {
                                a(this).css("display", "none");
                                d = "display:none;"
                            }
                            aa = aa + ("<td role='gridcell' style='height:0px;width:" + C + "px;" + d + "'></td>");
                            e.headers[b] = {
                                width: C,
                                el: this
                            };
                            J = c.p.colModel[b].sortable;
                            if (typeof J !== "boolean") J = c.p.colModel[b].sortable = true;
                            d = c.p.colModel[b].name;
                            d === "cb" || (d === "subgrid" || d === "rn") || c.p.viewsortcols[2] && a(">div", this).addClass("ui-jqgrid-sortable");
                            if (J)
                                if (c.p.multiSort)
                                    if (c.p.viewsortcols[0]) {
                                        a("div span.s-ico", this).show();
                                        c.p.colModel[b].lso && a("div span.ui-icon-" + c.p.colModel[b].lso, this).removeClass("ui-state-disabled")
                                    } else {
                                        if (c.p.colModel[b].lso) {
                                            a("div span.s-ico", this).show();
                                            a("div span.ui-icon-" + c.p.colModel[b].lso, this).removeClass("ui-state-disabled")
                                        }
                                    } else if (c.p.viewsortcols[0]) {
                                a("div span.s-ico", this).show();
                                b === c.p.lastsort && a("div span.ui-icon-" + c.p.sortorder, this).removeClass("ui-state-disabled")
                            } else if (b === c.p.lastsort) {
                                a("div span.s-ico",
                                    this).show();
                                a("div span.ui-icon-" + c.p.sortorder, this).removeClass("ui-state-disabled")
                            }
                            c.p.footerrow && (W = W + ("<td role='gridcell' " + n(b, 0, "", null, "", false) + ">&#160;</td>"))
                        }).mousedown(function(b) {
                            if (a(b.target).closest("th>span.ui-jqgrid-resize").length === 1) {
                                var d = R(this);
                                if (c.p.forceFit === true) {
                                    var f = c.p,
                                        g = d,
                                        i;
                                    for (i = d + 1; i < c.p.colModel.length; i++)
                                        if (c.p.colModel[i].hidden !== true) {
                                            g = i;
                                            break
                                        }
                                    f.nv = g - d
                                }
                                e.dragStart(d, b, Y(d));
                                return false
                            }
                        }).click(function(b) {
                            if (c.p.disableClick) return c.p.disableClick =
                                false;
                            var d = "th>div.ui-jqgrid-sortable",
                                e, f;
                            c.p.viewsortcols[2] || (d = "th>div>span>span.ui-grid-ico-sort");
                            b = a(b.target).closest(d);
                            if (b.length === 1) {
                                var g;
                                if (c.p.frozenColumns) {
                                    var i = a(this)[0].id.substring(c.p.id.length + 1);
                                    a(c.p.colModel).each(function(a) {
                                        if (this.name === i) {
                                            g = a;
                                            return false
                                        }
                                    })
                                } else g = R(this); if (!c.p.viewsortcols[2]) {
                                    e = true;
                                    f = b.attr("sort")
                                }
                                g != null && F(a("div", this)[0].id, g, e, f, this);
                                return false
                            }
                        });
                        if (c.p.sortable && a.fn.sortable) try {
                            a(c).jqGrid("sortableColumns", j)
                        } catch (ia) {}
                        c.p.footerrow &&
                            (W += "</tr></tbody></table>");
                        aa += "</tr>";
                        this.appendChild(document.createElement("tbody"));
                        a(this).addClass("ui-jqgrid-btable").append(aa);
                        var aa = null,
                            j = a("<table class='ui-jqgrid-htable' style='width:" + c.p.tblwidth + "px' role='grid' aria-labelledby='gbox_" + this.id + "' cellspacing='0' cellpadding='0' border='0'></table>").append(E),
                            T = c.p.caption && !0 === c.p.hiddengrid ? !0 : !1;
                        g = a("<div class='ui-jqgrid-hbox" + ("rtl" === i ? "-rtl" : "") + "'></div>");
                        E = null;
                        e.hDiv = document.createElement("div");
                        a(e.hDiv).css({
                            width: e.width +
                                "px"
                        }).addClass("ui-state-default ui-jqgrid-hdiv").append(g);
                        a(g).append(j);
                        j = null;
                        T && a(e.hDiv).hide();
                        c.p.pager && ("string" === typeof c.p.pager ? "#" !== c.p.pager.substr(0, 1) && (c.p.pager = "#" + c.p.pager) : c.p.pager = "#" + a(c.p.pager).attr("id"), a(c.p.pager).css({
                            width: e.width + "px"
                        }).addClass("ui-state-default ui-jqgrid-pager ui-corner-bottom").appendTo(m), T && a(c.p.pager).hide(), N(c.p.pager, ""));
                        !1 === c.p.cellEdit && !0 === c.p.hoverrows && a(c).bind("mouseover", function(c) {
                            I = a(c.target).closest("tr.jqgrow");
                            a(I).attr("class") !==
                                "ui-subgrid" && a(I).addClass("ui-state-hover")
                        }).bind("mouseout", function(c) {
                            I = a(c.target).closest("tr.jqgrow");
                            a(I).removeClass("ui-state-hover")
                        });
                        var P, X, da;
                        a(c).before(e.hDiv).click(function(b) {
                            M = b.target;
                            I = a(M, c.rows).closest("tr.jqgrow");
                            if (a(I).length === 0 || I[0].className.indexOf("ui-state-disabled") > -1 || (a(M, c).closest("table.ui-jqgrid-btable").attr("id") || "").replace("_frozen", "") !== c.id) return this;
                            var d = a(M).hasClass("cbox"),
                                e = a(c).triggerHandler("jqGridBeforeSelectRow", [I[0].id, b]);
                            (e = e ===
                                false || e === "stop" ? false : true) && a.isFunction(c.p.beforeSelectRow) && (e = c.p.beforeSelectRow.call(c, I[0].id, b));
                            if (!(M.tagName === "A" || (M.tagName === "INPUT" || M.tagName === "TEXTAREA" || M.tagName === "OPTION" || M.tagName === "SELECT") && !d) && e === true) {
                                P = I[0].id;
                                X = a.jgrid.getCellIndex(M);
                                da = a(M).closest("td,th").html();
                                a(c).triggerHandler("jqGridCellSelect", [P, X, da, b]);
                                a.isFunction(c.p.onCellSelect) && c.p.onCellSelect.call(c, P, X, da, b);
                                if (c.p.cellEdit === true)
                                    if (c.p.multiselect && d) a(c).jqGrid("setSelection", P, true, b);
                                    else {
                                        P = I[0].rowIndex;
                                        try {
                                            a(c).jqGrid("editCell", P, X, true)
                                        } catch (f) {}
                                    } else if (c.p.multikey)
                                    if (b[c.p.multikey]) a(c).jqGrid("setSelection", P, true, b);
                                    else {
                                        if (c.p.multiselect && d) {
                                            d = a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + P).is(":checked");
                                            a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + P)[c.p.useProp ? "prop" : "attr"]("checked", d)
                                        }
                                    } else {
                                    if (c.p.multiselect && c.p.multiboxonly && !d) {
                                        var g = c.p.frozenColumns ? c.p.id + "_frozen" : "";
                                        a(c.p.selarrrow).each(function(b, d) {
                                            var e = a(c).jqGrid("getGridRowById", d);
                                            e && a(e).removeClass("ui-state-highlight");
                                            a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(d))[c.p.useProp ? "prop" : "attr"]("checked", false);
                                            if (g) {
                                                a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(g)).removeClass("ui-state-highlight");
                                                a("#jqg_" + a.jgrid.jqID(c.p.id) + "_" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(g))[c.p.useProp ? "prop" : "attr"]("checked", false)
                                            }
                                        });
                                        c.p.selarrrow = []
                                    }
                                    a(c).jqGrid("setSelection", P, true, b)
                                }
                            }
                        }).bind("reloadGrid", function(b, d) {
                            if (c.p.treeGrid === true) c.p.datatype = c.p.treedatatype;
                            d && d.current && c.grid.selectionPreserver(c);
                            if (c.p.datatype ===
                                "local") {
                                a(c).jqGrid("resetSelection");
                                c.p.data.length && x()
                            } else if (!c.p.treeGrid) {
                                c.p.selrow = null;
                                if (c.p.multiselect) {
                                    c.p.selarrrow = [];
                                    O(false)
                                }
                                c.p.savedRow = []
                            }
                            c.p.scroll && v.call(c, true, false);
                            if (d && d.page) {
                                var e = d.page;
                                if (e > c.p.lastpage) e = c.p.lastpage;
                                e < 1 && (e = 1);
                                c.p.page = e;
                                c.grid.bDiv.scrollTop = c.grid.prevRowHeight ? (e - 1) * c.grid.prevRowHeight * c.p.rowNum : 0
                            }
                            if (c.grid.prevRowHeight && c.p.scroll) {
                                delete c.p.lastpage;
                                c.grid.populateVisible()
                            } else c.grid.populate();
                            c.p._inlinenav === true && a(c).jqGrid("showAddEditButtons");
                            return false
                        }).dblclick(function(b) {
                            M = b.target;
                            I = a(M, c.rows).closest("tr.jqgrow");
                            if (a(I).length !== 0) {
                                P = I[0].rowIndex;
                                X = a.jgrid.getCellIndex(M);
                                a(c).triggerHandler("jqGridDblClickRow", [a(I).attr("id"), P, X, b]);
                                a.isFunction(c.p.ondblClickRow) && c.p.ondblClickRow.call(c, a(I).attr("id"), P, X, b)
                            }
                        }).bind("contextmenu", function(b) {
                            M = b.target;
                            I = a(M, c.rows).closest("tr.jqgrow");
                            if (a(I).length !== 0) {
                                c.p.multiselect || a(c).jqGrid("setSelection", I[0].id, true, b);
                                P = I[0].rowIndex;
                                X = a.jgrid.getCellIndex(M);
                                a(c).triggerHandler("jqGridRightClickRow", [a(I).attr("id"), P, X, b]);
                                a.isFunction(c.p.onRightClickRow) && c.p.onRightClickRow.call(c, a(I).attr("id"), P, X, b)
                            }
                        });
                        e.bDiv = document.createElement("div");
                        k && "auto" === ("" + c.p.height).toLowerCase() && (c.p.height = "100%");
                        a(e.bDiv).append(a('<div style="position:relative;' + (k && 8 > a.jgrid.msiever() ? "height:0.01%;" : "") + '"></div>').append("<div></div>").append(this)).addClass("ui-jqgrid-bdiv").css({
                            height: c.p.height + (isNaN(c.p.height) ? "" : "px"),
                            width: e.width + "px"
                        }).scroll(e.scrollGrid);
                        a("table:first", e.bDiv).css({
                            width: c.p.tblwidth +
                                "px"
                        });
                        a.support.tbody || 2 === a("tbody", this).length && a("tbody:gt(0)", this).remove();
                        c.p.multikey && (a.jgrid.msie ? a(e.bDiv).bind("selectstart", function() {
                            return false
                        }) : a(e.bDiv).bind("mousedown", function() {
                            return false
                        }));
                        T && a(e.bDiv).hide();
                        e.cDiv = document.createElement("div");
                        var ea = !0 === c.p.hidegrid ? a("<a role='link' class='ui-jqgrid-titlebar-close ui-corner-all HeaderButton' />").hover(function() {
                            ea.addClass("ui-state-hover")
                        }, function() {
                            ea.removeClass("ui-state-hover")
                        }).append("<span class='ui-icon ui-icon-circle-triangle-n'></span>").css("rtl" ===
                            i ? "left" : "right", "0px") : "";
                        a(e.cDiv).append(ea).append("<span class='ui-jqgrid-title'>" + c.p.caption + "</span>").addClass("ui-jqgrid-titlebar ui-jqgrid-caption" + ("rtl" === i ? "-rtl" : "") + " ui-widget-header ui-corner-top ui-helper-clearfix");
                        a(e.cDiv).insertBefore(e.hDiv);
                        c.p.toolbar[0] && (e.uDiv = document.createElement("div"), "top" === c.p.toolbar[1] ? a(e.uDiv).insertBefore(e.hDiv) : "bottom" === c.p.toolbar[1] && a(e.uDiv).insertAfter(e.hDiv), "both" === c.p.toolbar[1] ? (e.ubDiv = document.createElement("div"), a(e.uDiv).addClass("ui-userdata ui-state-default").attr("id",
                            "t_" + this.id).insertBefore(e.hDiv), a(e.ubDiv).addClass("ui-userdata ui-state-default").attr("id", "tb_" + this.id).insertAfter(e.hDiv), T && a(e.ubDiv).hide()) : a(e.uDiv).width(e.width).addClass("ui-userdata ui-state-default").attr("id", "t_" + this.id), T && a(e.uDiv).hide());
                        c.p.toppager && (c.p.toppager = a.jgrid.jqID(c.p.id) + "_toppager", e.topDiv = a("<div id='" + c.p.toppager + "'></div>")[0], c.p.toppager = "#" + c.p.toppager, a(e.topDiv).addClass("ui-state-default ui-jqgrid-toppager").width(e.width).insertBefore(e.hDiv),
                            N(c.p.toppager, "_t"));
                        c.p.footerrow && (e.sDiv = a("<div class='ui-jqgrid-sdiv'></div>")[0], g = a("<div class='ui-jqgrid-hbox" + ("rtl" === i ? "-rtl" : "") + "'></div>"), a(e.sDiv).append(g).width(e.width).insertAfter(e.hDiv), a(g).append(W), e.footers = a(".ui-jqgrid-ftable", e.sDiv)[0].rows[0].cells, c.p.rownumbers && (e.footers[0].className = "ui-state-default jqgrid-rownum"), T && a(e.sDiv).hide());
                        g = null;
                        if (c.p.caption) {
                            var ha = c.p.datatype;
                            !0 === c.p.hidegrid && (a(".ui-jqgrid-titlebar-close", e.cDiv).click(function(b) {
                                var d =
                                    a.isFunction(c.p.onHeaderClick),
                                    f = ".ui-jqgrid-bdiv, .ui-jqgrid-hdiv, .ui-jqgrid-pager, .ui-jqgrid-sdiv",
                                    g, i = this;
                                if (c.p.toolbar[0] === true) {
                                    c.p.toolbar[1] === "both" && (f = f + (", #" + a(e.ubDiv).attr("id")));
                                    f = f + (", #" + a(e.uDiv).attr("id"))
                                }
                                g = a(f, "#gview_" + a.jgrid.jqID(c.p.id)).length;
                                c.p.gridstate === "visible" ? a(f, "#gbox_" + a.jgrid.jqID(c.p.id)).slideUp("fast", function() {
                                    g--;
                                    if (g === 0) {
                                        a("span", i).removeClass("ui-icon-circle-triangle-n").addClass("ui-icon-circle-triangle-s");
                                        c.p.gridstate = "hidden";
                                        a("#gbox_" +
                                            a.jgrid.jqID(c.p.id)).hasClass("ui-resizable") && a(".ui-resizable-handle", "#gbox_" + a.jgrid.jqID(c.p.id)).hide();
                                        a(c).triggerHandler("jqGridHeaderClick", [c.p.gridstate, b]);
                                        d && (T || c.p.onHeaderClick.call(c, c.p.gridstate, b))
                                    }
                                }) : c.p.gridstate === "hidden" && a(f, "#gbox_" + a.jgrid.jqID(c.p.id)).slideDown("fast", function() {
                                    g--;
                                    if (g === 0) {
                                        a("span", i).removeClass("ui-icon-circle-triangle-s").addClass("ui-icon-circle-triangle-n");
                                        if (T) {
                                            c.p.datatype = ha;
                                            B();
                                            T = false
                                        }
                                        c.p.gridstate = "visible";
                                        a("#gbox_" + a.jgrid.jqID(c.p.id)).hasClass("ui-resizable") &&
                                            a(".ui-resizable-handle", "#gbox_" + a.jgrid.jqID(c.p.id)).show();
                                        a(c).triggerHandler("jqGridHeaderClick", [c.p.gridstate, b]);
                                        d && (T || c.p.onHeaderClick.call(c, c.p.gridstate, b))
                                    }
                                });
                                return false
                            }), T && (c.p.datatype = "local", a(".ui-jqgrid-titlebar-close", e.cDiv).trigger("click")))
                        } else a(e.cDiv).hide(), a(e.hDiv).addClass("ui-corner-top");
                        a(e.hDiv).after(e.bDiv).mousemove(function(a) {
                            if (e.resizing) {
                                e.dragMove(a);
                                return false
                            }
                        });
                        a(".ui-jqgrid-labels", e.hDiv).bind("selectstart", function() {
                            return false
                        });
                        a(document).bind("mouseup.jqGrid" +
                            c.p.id, function() {
                                if (e.resizing) {
                                    e.dragEnd();
                                    return false
                                }
                                return true
                            });
                        c.formatCol = n;
                        c.sortData = F;
                        c.updatepager = function(b, d) {
                            var e, f, g, i, j, h, l, m = "",
                                k = c.p.pager ? "_" + a.jgrid.jqID(c.p.pager.substr(1)) : "",
                                n = c.p.toppager ? "_" + c.p.toppager.substr(1) : "";
                            g = parseInt(c.p.page, 10) - 1;
                            g < 0 && (g = 0);
                            g = g * parseInt(c.p.rowNum, 10);
                            j = g + c.p.reccount;
                            if (c.p.scroll) {
                                e = a("tbody:first > tr:gt(0)", c.grid.bDiv);
                                g = j - e.length;
                                c.p.reccount = e.length;
                                if (e = e.outerHeight() || c.grid.prevRowHeight) {
                                    f = g * e;
                                    l = parseInt(c.p.records, 10) * e;
                                    a(">div:first", c.grid.bDiv).css({
                                        height: l
                                    }).children("div:first").css({
                                        height: f,
                                        display: f ? "" : "none"
                                    });
                                    if (c.grid.bDiv.scrollTop == 0 && c.p.page > 1) c.grid.bDiv.scrollTop = c.p.rowNum * (c.p.page - 1) * e
                                }
                                c.grid.bDiv.scrollLeft = c.grid.hDiv.scrollLeft
                            }
                            m = c.p.pager || "";
                            if (m = m + (c.p.toppager ? m ? "," + c.p.toppager : c.p.toppager : "")) {
                                l = a.jgrid.formatter.integer || {};
                                e = o(c.p.page);
                                f = o(c.p.lastpage);
                                a(".selbox", m)[this.p.useProp ? "prop" : "attr"]("disabled", false);
                                if (c.p.pginput === true) {
                                    a(".ui-pg-input", m).val(c.p.page);
                                    i = c.p.toppager ?
                                        "#sp_1" + k + ",#sp_1" + n : "#sp_1" + k;
                                    a(i).html(a.fmatter ? a.fmatter.util.NumberFormat(c.p.lastpage, l) : c.p.lastpage)
                                }
                                if (c.p.viewrecords)
                                    if (c.p.reccount === 0) a(".ui-paging-info", m).html(c.p.emptyrecords);
                                    else {
                                        i = g + 1;
                                        h = c.p.records;
                                        if (a.fmatter) {
                                            i = a.fmatter.util.NumberFormat(i, l);
                                            j = a.fmatter.util.NumberFormat(j, l);
                                            h = a.fmatter.util.NumberFormat(h, l)
                                        }
                                        a(".ui-paging-info", m).html(a.jgrid.format(c.p.recordtext, i, j, h))
                                    }
                                if (c.p.pgbuttons === true) {
                                    e <= 0 && (e = f = 0);
                                    if (e === 1 || e === 0) {
                                        a("#first" + k + ", #prev" + k).addClass("ui-state-disabled").removeClass("ui-state-hover");
                                        c.p.toppager && a("#first_t" + n + ", #prev_t" + n).addClass("ui-state-disabled").removeClass("ui-state-hover")
                                    } else {
                                        a("#first" + k + ", #prev" + k).removeClass("ui-state-disabled");
                                        c.p.toppager && a("#first_t" + n + ", #prev_t" + n).removeClass("ui-state-disabled")
                                    } if (e === f || e === 0) {
                                        a("#next" + k + ", #last" + k).addClass("ui-state-disabled").removeClass("ui-state-hover");
                                        c.p.toppager && a("#next_t" + n + ", #last_t" + n).addClass("ui-state-disabled").removeClass("ui-state-hover")
                                    } else {
                                        a("#next" + k + ", #last" + k).removeClass("ui-state-disabled");
                                        c.p.toppager && a("#next_t" + n + ", #last_t" + n).removeClass("ui-state-disabled")
                                    }
                                }
                            }
                            b === true && c.p.rownumbers === true && a(">td.jqgrid-rownum", c.rows).each(function(b) {
                                a(this).html(g + 1 + b)
                            });
                            d && c.p.jqgdnd && a(c).jqGrid("gridDnD", "updateDnD");
                            a(c).triggerHandler("jqGridGridComplete");
                            a.isFunction(c.p.gridComplete) && c.p.gridComplete.call(c);
                            a(c).triggerHandler("jqGridAfterGridComplete")
                        };
                        c.refreshIndex = x;
                        c.setHeadCheckBox = O;
                        c.constructTr = H;
                        c.formatter = function(a, b, c, d, e) {
                            return p(a, b, c, d, e)
                        };
                        a.extend(e, {
                            populate: B,
                            emptyRows: v,
                            beginReq: u,
                            endReq: A
                        });
                        this.grid = e;
                        c.addXmlData = function(a) {
                            y(a, c.grid.bDiv)
                        };
                        c.addJSONData = function(a) {
                            D(a, c.grid.bDiv)
                        };
                        this.grid.cols = this.rows[0].cells;
                        a(c).triggerHandler("jqGridInitGrid");
                        a.isFunction(c.p.onInitGrid) && c.p.onInitGrid.call(c);
                        B();
                        c.p.hiddengrid = !1
                    }
                }
            }
        })
    };
    a.jgrid.extend({
        getGridParam: function(a) {
            var e = this[0];
            if (e && e.grid) return !a ? e.p : void 0 !== e.p[a] ? e.p[a] : null
        },
        setGridParam: function(d, e) {
            return this.each(function() {
                null == e && (e = !1);
                this.grid && "object" === typeof d && (!0 ===
                    e ? this.p = a.extend({}, this.p, d) : a.extend(!0, this.p, d))
            })
        },
        getGridRowById: function(d) {
            var e;
            this.each(function() {
                try {
                    for (var b = this.rows.length; b--;)
                        if (d.toString() === this.rows[b].id) {
                            e = this.rows[b];
                            break
                        }
                } catch (f) {
                    e = a(this.grid.bDiv).find("#" + a.jgrid.jqID(d))
                }
            });
            return e
        },
        getDataIDs: function() {
            var d = [],
                e = 0,
                b, f = 0;
            this.each(function() {
                if ((b = this.rows.length) && 0 < b)
                    for (; e < b;) a(this.rows[e]).hasClass("jqgrow") && (d[f] = this.rows[e].id, f++), e++
            });
            return d
        },
        setSelection: function(d, e, b) {
            return this.each(function() {
                var f,
                    c, h, g, i, j;
                if (void 0 !== d && (e = !1 === e ? !1 : !0, (c = a(this).jqGrid("getGridRowById", d)) && c.className && !(-1 < c.className.indexOf("ui-state-disabled"))))
                    if (!0 === this.p.scrollrows && (h = a(this).jqGrid("getGridRowById", d).rowIndex, 0 <= h && (f = a(this.grid.bDiv)[0].clientHeight, g = a(this.grid.bDiv)[0].scrollTop, i = a(this.rows[h]).position().top, h = this.rows[h].clientHeight, i + h >= f + g ? a(this.grid.bDiv)[0].scrollTop = i - (f + g) + h + g : i < f + g && i < g && (a(this.grid.bDiv)[0].scrollTop = i))), !0 === this.p.frozenColumns && (j = this.p.id + "_frozen"),
                        this.p.multiselect) {
                        if (this.setHeadCheckBox(!1), this.p.selrow = c.id, g = a.inArray(this.p.selrow, this.p.selarrrow), -1 === g ? ("ui-subgrid" !== c.className && a(c).addClass("ui-state-highlight").attr("aria-selected", "true"), f = !0, this.p.selarrrow.push(this.p.selrow)) : ("ui-subgrid" !== c.className && a(c).removeClass("ui-state-highlight").attr("aria-selected", "false"), f = !1, this.p.selarrrow.splice(g, 1), i = this.p.selarrrow[0], this.p.selrow = void 0 === i ? null : i), a("#jqg_" + a.jgrid.jqID(this.p.id) + "_" + a.jgrid.jqID(c.id))[this.p.useProp ?
                            "prop" : "attr"]("checked", f), j && (-1 === g ? a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(j)).addClass("ui-state-highlight") : a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(j)).removeClass("ui-state-highlight"), a("#jqg_" + a.jgrid.jqID(this.p.id) + "_" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(j))[this.p.useProp ? "prop" : "attr"]("checked", f)), e) a(this).triggerHandler("jqGridSelectRow", [c.id, f, b]), this.p.onSelectRow && this.p.onSelectRow.call(this, c.id, f, b)
                    } else if ("ui-subgrid" !== c.className && (this.p.selrow !== c.id ? ((f = a(this).jqGrid("getGridRowById",
                    this.p.selrow)) && a(f).removeClass("ui-state-highlight").attr({
                    "aria-selected": "false",
                    tabindex: "-1"
                }), a(c).addClass("ui-state-highlight").attr({
                    "aria-selected": "true",
                    tabindex: "0"
                }), j && (a("#" + a.jgrid.jqID(this.p.selrow), "#" + a.jgrid.jqID(j)).removeClass("ui-state-highlight"), a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(j)).addClass("ui-state-highlight")), f = !0) : f = !1, this.p.selrow = c.id, e)) a(this).triggerHandler("jqGridSelectRow", [c.id, f, b]), this.p.onSelectRow && this.p.onSelectRow.call(this, c.id, f, b)
            })
        },
        resetSelection: function(d) {
            return this.each(function() {
                var e =
                    this,
                    b, f;
                !0 === e.p.frozenColumns && (f = e.p.id + "_frozen");
                if (void 0 !== d) {
                    b = d === e.p.selrow ? e.p.selrow : d;
                    a("#" + a.jgrid.jqID(e.p.id) + " tbody:first tr#" + a.jgrid.jqID(b)).removeClass("ui-state-highlight").attr("aria-selected", "false");
                    f && a("#" + a.jgrid.jqID(b), "#" + a.jgrid.jqID(f)).removeClass("ui-state-highlight");
                    if (e.p.multiselect) {
                        a("#jqg_" + a.jgrid.jqID(e.p.id) + "_" + a.jgrid.jqID(b), "#" + a.jgrid.jqID(e.p.id))[e.p.useProp ? "prop" : "attr"]("checked", !1);
                        if (f) a("#jqg_" + a.jgrid.jqID(e.p.id) + "_" + a.jgrid.jqID(b), "#" +
                            a.jgrid.jqID(f))[e.p.useProp ? "prop" : "attr"]("checked", !1);
                        e.setHeadCheckBox(!1)
                    }
                    b = null
                } else e.p.multiselect ? (a(e.p.selarrrow).each(function(b, d) {
                    a(a(e).jqGrid("getGridRowById", d)).removeClass("ui-state-highlight").attr("aria-selected", "false");
                    a("#jqg_" + a.jgrid.jqID(e.p.id) + "_" + a.jgrid.jqID(d))[e.p.useProp ? "prop" : "attr"]("checked", !1);
                    f && (a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(f)).removeClass("ui-state-highlight"), a("#jqg_" + a.jgrid.jqID(e.p.id) + "_" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(f))[e.p.useProp ?
                        "prop" : "attr"]("checked", !1))
                }), e.setHeadCheckBox(!1), e.p.selarrrow = [], e.p.selrow = null) : e.p.selrow && (a("#" + a.jgrid.jqID(e.p.id) + " tbody:first tr#" + a.jgrid.jqID(e.p.selrow)).removeClass("ui-state-highlight").attr("aria-selected", "false"), f && a("#" + a.jgrid.jqID(e.p.selrow), "#" + a.jgrid.jqID(f)).removeClass("ui-state-highlight"), e.p.selrow = null);
                !0 === e.p.cellEdit && (0 <= parseInt(e.p.iCol, 10) && 0 <= parseInt(e.p.iRow, 10)) && (a("td:eq(" + e.p.iCol + ")", e.rows[e.p.iRow]).removeClass("edit-cell ui-state-highlight"),
                    a(e.rows[e.p.iRow]).removeClass("selected-row ui-state-hover"));
                e.p.savedRow = []
            })
        },
        getRowData: function(d) {
            var e = {},
                b, f = !1,
                c, h = 0;
            this.each(function() {
                var g = this,
                    i, j;
                if (void 0 === d) f = !0, b = [], c = g.rows.length;
                else {
                    j = a(g).jqGrid("getGridRowById", d);
                    if (!j) return e;
                    c = 2
                }
                for (; h < c;) f && (j = g.rows[h]), a(j).hasClass("jqgrow") && (a('td[role="gridcell"]', j).each(function(b) {
                    i = g.p.colModel[b].name;
                    if ("cb" !== i && "subgrid" !== i && "rn" !== i)
                        if (!0 === g.p.treeGrid && i === g.p.ExpandColumn) e[i] = a.jgrid.htmlDecode(a("span:first",
                            this).html());
                        else try {
                            e[i] = a.unformat.call(g, this, {
                                rowId: j.id,
                                colModel: g.p.colModel[b]
                            }, b)
                        } catch (c) {
                            e[i] = a.jgrid.htmlDecode(a(this).html())
                        }
                }), f && (b.push(e), e = {})), h++
            });
            return b || e
        },
        delRowData: function(d) {
            var e = !1,
                b, f, c;
            this.each(function() {
                b = a(this).jqGrid("getGridRowById", d);
                if (!b) return !1;
                this.p.subGrid && (c = a(b).next(), c.hasClass("ui-subgrid") && c.remove());
                a(b).remove();
                this.p.records--;
                this.p.reccount--;
                this.updatepager(!0, !1);
                e = !0;
                this.p.multiselect && (f = a.inArray(d, this.p.selarrrow), -1 !== f &&
                    this.p.selarrrow.splice(f, 1));
                this.p.selrow = this.p.multiselect && 0 < this.p.selarrrow.length ? this.p.selarrrow[this.p.selarrrow.length - 1] : null;
                if ("local" === this.p.datatype) {
                    var h = this.p._index[a.jgrid.stripPref(this.p.idPrefix, d)];
                    void 0 !== h && (this.p.data.splice(h, 1), this.refreshIndex())
                }
                if (!0 === this.p.altRows && e) {
                    var g = this.p.altclass;
                    a(this.rows).each(function(b) {
                        b % 2 === 1 ? a(this).addClass(g) : a(this).removeClass(g)
                    })
                }
            });
            return e
        },
        setRowData: function(d, e, b) {
            var f, c = !0,
                h;
            this.each(function() {
                if (!this.grid) return !1;
                var g = this,
                    i, j, k = typeof b,
                    m = {};
                j = a(this).jqGrid("getGridRowById", d);
                if (!j) return !1;
                if (e) try {
                    if (a(this.p.colModel).each(function(b) {
                        f = this.name;
                        var c = a.jgrid.getAccessor(e, f);
                        void 0 !== c && (m[f] = this.formatter && "string" === typeof this.formatter && "date" === this.formatter ? a.unformat.date.call(g, c, this) : c, i = g.formatter(d, c, b, e, "edit"), h = this.title ? {
                            title: a.jgrid.stripHtml(i)
                        } : {}, !0 === g.p.treeGrid && f === g.p.ExpandColumn ? a("td[role='gridcell']:eq(" + b + ") > span:first", j).html(i).attr(h) : a("td[role='gridcell']:eq(" +
                            b + ")", j).html(i).attr(h))
                    }), "local" === g.p.datatype) {
                        var o = a.jgrid.stripPref(g.p.idPrefix, d),
                            n = g.p._index[o],
                            l;
                        if (g.p.treeGrid)
                            for (l in g.p.treeReader) g.p.treeReader.hasOwnProperty(l) && delete m[g.p.treeReader[l]];
                        void 0 !== n && (g.p.data[n] = a.extend(!0, g.p.data[n], m));
                        m = null
                    }
                } catch (p) {
                    c = !1
                }
                c && ("string" === k ? a(j).addClass(b) : null !== b && "object" === k && a(j).css(b), a(g).triggerHandler("jqGridAfterGridComplete"))
            });
            return c
        },
        addRowData: function(d, e, b, f) {
            b || (b = "last");
            var c = !1,
                h, g, i, j, k, m, o, n, l = "",
                p, r, q, s, t, w;
            e && (a.isArray(e) ? (p = !0, b = "last", r = d) : (e = [e], p = !1), this.each(function() {
                var v = e.length;
                k = this.p.rownumbers === true ? 1 : 0;
                i = this.p.multiselect === true ? 1 : 0;
                j = this.p.subGrid === true ? 1 : 0;
                if (!p)
                    if (d !== void 0) d = "" + d;
                    else {
                        d = a.jgrid.randId();
                        if (this.p.keyName !== false) {
                            r = this.p.keyName;
                            e[0][r] !== void 0 && (d = e[0][r])
                        }
                    }
                q = this.p.altclass;
                for (var x = 0, H = "", y = {}, D = a.isFunction(this.p.afterInsertRow) ? true : false; x < v;) {
                    s = e[x];
                    g = [];
                    if (p) {
                        try {
                            d = s[r];
                            d === void 0 && (d = a.jgrid.randId())
                        } catch (z) {
                            d = a.jgrid.randId()
                        }
                        H = this.p.altRows ===
                            true ? (this.rows.length - 1) % 2 === 0 ? q : "" : ""
                    }
                    w = d;
                    d = this.p.idPrefix + d;
                    if (k) {
                        l = this.formatCol(0, 1, "", null, d, true);
                        g[g.length] = '<td role="gridcell" class="ui-state-default jqgrid-rownum" ' + l + ">0</td>"
                    }
                    if (i) {
                        n = '<input role="checkbox" type="checkbox" id="jqg_' + this.p.id + "_" + d + '" class="cbox"/>';
                        l = this.formatCol(k, 1, "", null, d, true);
                        g[g.length] = '<td role="gridcell" ' + l + ">" + n + "</td>"
                    }
                    j && (g[g.length] = a(this).jqGrid("addSubGridCell", i + k, 1));
                    for (o = i + j + k; o < this.p.colModel.length; o++) {
                        t = this.p.colModel[o];
                        h = t.name;
                        y[h] = s[h];
                        n = this.formatter(d, a.jgrid.getAccessor(s, h), o, s);
                        l = this.formatCol(o, 1, n, s, d, y);
                        g[g.length] = '<td role="gridcell" ' + l + ">" + n + "</td>"
                    }
                    g.unshift(this.constructTr(d, false, H, y, s, false));
                    g[g.length] = "</tr>";
                    if (this.rows.length === 0) a("table:first", this.grid.bDiv).append(g.join(""));
                    else switch (b) {
                        case "last":
                            a(this.rows[this.rows.length - 1]).after(g.join(""));
                            m = this.rows.length - 1;
                            break;
                        case "first":
                            a(this.rows[0]).after(g.join(""));
                            m = 1;
                            break;
                        case "after":
                            if (m = a(this).jqGrid("getGridRowById", f)) {
                                a(this.rows[m.rowIndex +
                                    1]).hasClass("ui-subgrid") ? a(this.rows[m.rowIndex + 1]).after(g) : a(m).after(g.join(""));
                                m = m.rowIndex + 1
                            }
                            break;
                        case "before":
                            if (m = a(this).jqGrid("getGridRowById", f)) {
                                a(m).before(g.join(""));
                                m = m.rowIndex - 1
                            }
                    }
                    this.p.subGrid === true && a(this).jqGrid("addSubGrid", i + k, m);
                    this.p.records++;
                    this.p.reccount++;
                    a(this).triggerHandler("jqGridAfterInsertRow", [d, s, s]);
                    D && this.p.afterInsertRow.call(this, d, s, s);
                    x++;
                    if (this.p.datatype === "local") {
                        y[this.p.localReader.id] = w;
                        this.p._index[w] = this.p.data.length;
                        this.p.data.push(y);
                        y = {}
                    }
                }
                this.p.altRows === true && !p && (b === "last" ? (this.rows.length - 1) % 2 === 1 && a(this.rows[this.rows.length - 1]).addClass(q) : a(this.rows).each(function(b) {
                    b % 2 === 1 ? a(this).addClass(q) : a(this).removeClass(q)
                }));
                this.updatepager(true, true);
                c = true
            }));
            return c
        },
        footerData: function(d, e, b) {
            function f(a) {
                for (var b in a)
                    if (a.hasOwnProperty(b)) return !1;
                return !0
            }
            var c, h = !1,
                g = {},
                i;
            void 0 == d && (d = "get");
            "boolean" !== typeof b && (b = !0);
            d = d.toLowerCase();
            this.each(function() {
                var j = this,
                    k;
                if (!j.grid || !j.p.footerrow || "set" ===
                    d && f(e)) return !1;
                h = !0;
                a(this.p.colModel).each(function(f) {
                    c = this.name;
                    "set" === d ? void 0 !== e[c] && (k = b ? j.formatter("", e[c], f, e, "edit") : e[c], i = this.title ? {
                        title: a.jgrid.stripHtml(k)
                    } : {}, a("tr.footrow td:eq(" + f + ")", j.grid.sDiv).html(k).attr(i), h = !0) : "get" === d && (g[c] = a("tr.footrow td:eq(" + f + ")", j.grid.sDiv).html())
                })
            });
            return "get" === d ? g : h
        },
        showHideCol: function(d, e) {
            return this.each(function() {
                var b = this,
                    f = !1,
                    c = a.jgrid.cell_width ? 0 : b.p.cellLayout,
                    h;
                if (b.grid) {
                    "string" === typeof d && (d = [d]);
                    e = "none" !== e ? "" :
                        "none";
                    var g = "" === e ? !0 : !1,
                        i = b.p.groupHeader && ("object" === typeof b.p.groupHeader || a.isFunction(b.p.groupHeader));
                    i && a(b).jqGrid("destroyGroupHeader", !1);
                    a(this.p.colModel).each(function(i) {
                        if (-1 !== a.inArray(this.name, d) && this.hidden === g) {
                            if (!0 === b.p.frozenColumns && !0 === this.frozen) return !0;
                            a("tr[role=rowheader]", b.grid.hDiv).each(function() {
                                a(this.cells[i]).css("display", e)
                            });
                            a(b.rows).each(function() {
                                a(this).hasClass("jqgroup") || a(this.cells[i]).css("display", e)
                            });
                            b.p.footerrow && a("tr.footrow td:eq(" +
                                i + ")", b.grid.sDiv).css("display", e);
                            h = parseInt(this.width, 10);
                            b.p.tblwidth = "none" === e ? b.p.tblwidth - (h + c) : b.p.tblwidth + (h + c);
                            this.hidden = !g;
                            f = !0;
                            a(b).triggerHandler("jqGridShowHideCol", [g, this.name, i])
                        }
                    });
                    !0 === f && (!0 === b.p.shrinkToFit && !isNaN(b.p.height) && (b.p.tblwidth += parseInt(b.p.scrollOffset, 10)), a(b).jqGrid("setGridWidth", !0 === b.p.shrinkToFit ? b.p.tblwidth : b.p.width));
                    i && a(b).jqGrid("setGroupHeaders", b.p.groupHeader)
                }
            })
        },
        hideCol: function(d) {
            return this.each(function() {
                a(this).jqGrid("showHideCol",
                    d, "none")
            })
        },
        showCol: function(d) {
            return this.each(function() {
                a(this).jqGrid("showHideCol", d, "")
            })
        },
        remapColumns: function(d, e, b) {
            function f(b) {
                var c;
                c = b.length ? a.makeArray(b) : a.extend({}, b);
                a.each(d, function(a) {
                    b[a] = c[this]
                })
            }

            function c(b, c) {
                a(">tr" + (c || ""), b).each(function() {
                    var b = this,
                        c = a.makeArray(b.cells);
                    a.each(d, function() {
                        var a = c[this];
                        a && b.appendChild(a)
                    })
                })
            }
            var h = this.get(0);
            f(h.p.colModel);
            f(h.p.colNames);
            f(h.grid.headers);
            c(a("thead:first", h.grid.hDiv), b && ":not(.ui-jqgrid-labels)");
            e && c(a("#" +
                a.jgrid.jqID(h.p.id) + " tbody:first"), ".jqgfirstrow, tr.jqgrow, tr.jqfoot");
            h.p.footerrow && c(a("tbody:first", h.grid.sDiv));
            h.p.remapColumns && (h.p.remapColumns.length ? f(h.p.remapColumns) : h.p.remapColumns = a.makeArray(d));
            h.p.lastsort = a.inArray(h.p.lastsort, d);
            h.p.treeGrid && (h.p.expColInd = a.inArray(h.p.expColInd, d));
            a(h).triggerHandler("jqGridRemapColumns", [d, e, b])
        },
        setGridWidth: function(d, e) {
            return this.each(function() {
                if (this.grid) {
                    var b = this,
                        f, c = 0,
                        h = a.jgrid.cell_width ? 0 : b.p.cellLayout,
                        g, i = 0,
                        j = !1,
                        k =
                        b.p.scrollOffset,
                        m, o = 0,
                        n;
                    "boolean" !== typeof e && (e = b.p.shrinkToFit);
                    if (!isNaN(d)) {
                        d = parseInt(d, 10);
                        b.grid.width = b.p.width = d;
                        a("#gbox_" + a.jgrid.jqID(b.p.id)).css("width", d + "px");
                        a("#gview_" + a.jgrid.jqID(b.p.id)).css("width", d + "px");
                        a(b.grid.bDiv).css("width", d + "px");
                        a(b.grid.hDiv).css("width", d + "px");
                        b.p.pager && a(b.p.pager).css("width", d + "px");
                        b.p.toppager && a(b.p.toppager).css("width", d + "px");
                        !0 === b.p.toolbar[0] && (a(b.grid.uDiv).css("width", d + "px"), "both" === b.p.toolbar[1] && a(b.grid.ubDiv).css("width",
                            d + "px"));
                        b.p.footerrow && a(b.grid.sDiv).css("width", d + "px");
                        !1 === e && !0 === b.p.forceFit && (b.p.forceFit = !1);
                        if (!0 === e) {
                            a.each(b.p.colModel, function() {
                                if (this.hidden === false) {
                                    f = this.widthOrg;
                                    c = c + (f + h);
                                    this.fixed ? o = o + (f + h) : i++
                                }
                            });
                            if (0 === i) return;
                            b.p.tblwidth = c;
                            m = d - h * i - o;
                            if (!isNaN(b.p.height) && (a(b.grid.bDiv)[0].clientHeight < a(b.grid.bDiv)[0].scrollHeight || 1 === b.rows.length)) j = !0, m -= k;
                            var c = 0,
                                l = 0 < b.grid.cols.length;
                            a.each(b.p.colModel, function(a) {
                                if (this.hidden === false && !this.fixed) {
                                    f = this.widthOrg;
                                    f = Math.round(m *
                                        f / (b.p.tblwidth - h * i - o));
                                    if (!(f < 0)) {
                                        this.width = f;
                                        c = c + f;
                                        b.grid.headers[a].width = f;
                                        b.grid.headers[a].el.style.width = f + "px";
                                        if (b.p.footerrow) b.grid.footers[a].style.width = f + "px";
                                        if (l) b.grid.cols[a].style.width = f + "px";
                                        g = a
                                    }
                                }
                            });
                            if (!g) return;
                            n = 0;
                            j ? d - o - (c + h * i) !== k && (n = d - o - (c + h * i) - k) : 1 !== Math.abs(d - o - (c + h * i)) && (n = d - o - (c + h * i));
                            b.p.colModel[g].width += n;
                            b.p.tblwidth = c + n + h * i + o;
                            b.p.tblwidth > d ? (j = b.p.tblwidth - parseInt(d, 10), b.p.tblwidth = d, f = b.p.colModel[g].width -= j) : f = b.p.colModel[g].width;
                            b.grid.headers[g].width =
                                f;
                            b.grid.headers[g].el.style.width = f + "px";
                            l && (b.grid.cols[g].style.width = f + "px");
                            b.p.footerrow && (b.grid.footers[g].style.width = f + "px")
                        }
                        b.p.tblwidth && (a("table:first", b.grid.bDiv).css("width", b.p.tblwidth + "px"), a("table:first", b.grid.hDiv).css("width", b.p.tblwidth + "px"), b.grid.hDiv.scrollLeft = b.grid.bDiv.scrollLeft, b.p.footerrow && a("table:first", b.grid.sDiv).css("width", b.p.tblwidth + "px"))
                    }
                }
            })
        },
        setGridHeight: function(d) {
            return this.each(function() {
                if (this.grid) {
                    var e = a(this.grid.bDiv);
                    e.css({
                        height: d +
                            (isNaN(d) ? "" : "px")
                    });
                    !0 === this.p.frozenColumns && a("#" + a.jgrid.jqID(this.p.id) + "_frozen").parent().height(e.height() - 16);
                    this.p.height = d;
                    this.p.scroll && this.grid.populateVisible()
                }
            })
        },
        setCaption: function(d) {
            return this.each(function() {
                this.p.caption = d;
                a("span.ui-jqgrid-title, span.ui-jqgrid-title-rtl", this.grid.cDiv).html(d);
                a(this.grid.cDiv).show();
                a(this.grid.hDiv).removeClass("ui-corner-top")
            })
        },
        setLabel: function(d, e, b, f) {
            return this.each(function() {
                var c = -1;
                if (this.grid && void 0 !== d && (a(this.p.colModel).each(function(a) {
                    if (this.name ===
                        d) return c = a, !1
                }), 0 <= c)) {
                    var h = a("tr.ui-jqgrid-labels th:eq(" + c + ")", this.grid.hDiv);
                    if (e) {
                        var g = a(".s-ico", h);
                        a("[id^=jqgh_]", h).empty().html(e).append(g);
                        this.p.colNames[c] = e
                    }
                    b && ("string" === typeof b ? a(h).addClass(b) : a(h).css(b));
                    "object" === typeof f && a(h).attr(f)
                }
            })
        },
        setCell: function(d, e, b, f, c, h) {
            return this.each(function() {
                var g = -1,
                    i, j;
                if (this.grid && (isNaN(e) ? a(this.p.colModel).each(function(a) {
                    if (this.name === e) return g = a, !1
                }) : g = parseInt(e, 10), 0 <= g && (i = a(this).jqGrid("getGridRowById", d)))) {
                    var k =
                        a("td:eq(" + g + ")", i);
                    j = 0;
                    var m = [];
                    if ("" !== b || !0 === h) {
                        for (; j < i.cells.length;) m.push(i.cells[j].innerHTML), j++;
                        i = this.formatter(d, b, g, m, "edit");
                        j = this.p.colModel[g].title ? {
                            title: a.jgrid.stripHtml(i)
                        } : {};
                        this.p.treeGrid && 0 < a(".tree-wrap", a(k)).length ? a("span", a(k)).html(i).attr(j) : a(k).html(i).attr(j);
                        "local" === this.p.datatype && (i = this.p.colModel[g], b = i.formatter && "string" === typeof i.formatter && "date" === i.formatter ? a.unformat.date.call(this, b, i) : b, j = this.p._index[a.jgrid.stripPref(this.p.idPrefix, d)],
                            void 0 !== j && (this.p.data[j][i.name] = b))
                    }
                    "string" === typeof f ? a(k).addClass(f) : f && a(k).css(f);
                    "object" === typeof c && a(k).attr(c)
                }
            })
        },
        getCell: function(d, e) {
            var b = !1;
            this.each(function() {
                var f = -1;
                if (this.grid && (isNaN(e) ? a(this.p.colModel).each(function(a) {
                    if (this.name === e) return f = a, !1
                }) : f = parseInt(e, 10), 0 <= f)) {
                    var c = a(this).jqGrid("getGridRowById", d);
                    if (c) try {
                        b = a.unformat.call(this, a("td:eq(" + f + ")", c), {
                            rowId: c.id,
                            colModel: this.p.colModel[f]
                        }, f)
                    } catch (h) {
                        b = a.jgrid.htmlDecode(a("td:eq(" + f + ")", c).html())
                    }
                }
            });
            return b
        },
        getCol: function(d, e, b) {
            var f = [],
                c, h = 0,
                g, i, j, e = "boolean" !== typeof e ? !1 : e;
            void 0 === b && (b = !1);
            this.each(function() {
                var k = -1;
                if (this.grid && (isNaN(d) ? a(this.p.colModel).each(function(a) {
                    if (this.name === d) return k = a, !1
                }) : k = parseInt(d, 10), 0 <= k)) {
                    var m = this.rows.length,
                        o = 0,
                        n = 0;
                    if (m && 0 < m) {
                        for (; o < m;) {
                            if (a(this.rows[o]).hasClass("jqgrow")) {
                                try {
                                    c = a.unformat.call(this, a(this.rows[o].cells[k]), {
                                        rowId: this.rows[o].id,
                                        colModel: this.p.colModel[k]
                                    }, k)
                                } catch (l) {
                                    c = a.jgrid.htmlDecode(this.rows[o].cells[k].innerHTML)
                                }
                                b ?
                                    (j = parseFloat(c), isNaN(j) || (h += j, void 0 === i && (i = g = j), g = Math.min(g, j), i = Math.max(i, j), n++)) : e ? f.push({
                                        id: this.rows[o].id,
                                        value: c
                                    }) : f.push(c)
                            }
                            o++
                        }
                        if (b) switch (b.toLowerCase()) {
                            case "sum":
                                f = h;
                                break;
                            case "avg":
                                f = h / n;
                                break;
                            case "count":
                                f = m - 1;
                                break;
                            case "min":
                                f = g;
                                break;
                            case "max":
                                f = i
                        }
                    }
                }
            });
            return f
        },
        clearGridData: function(d) {
            return this.each(function() {
                if (this.grid) {
                    "boolean" !== typeof d && (d = !1);
                    if (this.p.deepempty) a("#" + a.jgrid.jqID(this.p.id) + " tbody:first tr:gt(0)").remove();
                    else {
                        var e = a("#" + a.jgrid.jqID(this.p.id) +
                            " tbody:first tr:first")[0];
                        a("#" + a.jgrid.jqID(this.p.id) + " tbody:first").empty().append(e)
                    }
                    this.p.footerrow && d && a(".ui-jqgrid-ftable td", this.grid.sDiv).html("&#160;");
                    this.p.selrow = null;
                    this.p.selarrrow = [];
                    this.p.savedRow = [];
                    this.p.records = 0;
                    this.p.page = 1;
                    this.p.lastpage = 0;
                    this.p.reccount = 0;
                    this.p.data = [];
                    this.p._index = {};
                    this.updatepager(!0, !1)
                }
            })
        },
        getInd: function(d, e) {
            var b = !1,
                f;
            this.each(function() {
                (f = a(this).jqGrid("getGridRowById", d)) && (b = !0 === e ? f : f.rowIndex)
            });
            return b
        },
        bindKeys: function(d) {
            var e =
                a.extend({
                    onEnter: null,
                    onSpace: null,
                    onLeftKey: null,
                    onRightKey: null,
                    scrollingRows: !0
                }, d || {});
            return this.each(function() {
                var b = this;
                a("body").is("[role]") || a("body").attr("role", "application");
                b.p.scrollrows = e.scrollingRows;
                a(b).keydown(function(d) {
                    var c = a(b).find("tr[tabindex=0]")[0],
                        h, g, i, j = b.p.treeReader.expanded_field;
                    if (c)
                        if (i = b.p._index[a.jgrid.stripPref(b.p.idPrefix, c.id)], 37 === d.keyCode || 38 === d.keyCode || 39 === d.keyCode || 40 === d.keyCode) {
                            if (38 === d.keyCode) {
                                g = c.previousSibling;
                                h = "";
                                if (g)
                                    if (a(g).is(":hidden"))
                                        for (; g;) {
                                            if (g =
                                                g.previousSibling, !a(g).is(":hidden") && a(g).hasClass("jqgrow")) {
                                                h = g.id;
                                                break
                                            }
                                        } else h = g.id;
                                a(b).jqGrid("setSelection", h, !0, d);
                                d.preventDefault()
                            }
                            if (40 === d.keyCode) {
                                g = c.nextSibling;
                                h = "";
                                if (g)
                                    if (a(g).is(":hidden"))
                                        for (; g;) {
                                            if (g = g.nextSibling, !a(g).is(":hidden") && a(g).hasClass("jqgrow")) {
                                                h = g.id;
                                                break
                                            }
                                        } else h = g.id;
                                a(b).jqGrid("setSelection", h, !0, d);
                                d.preventDefault()
                            }
                            37 === d.keyCode && (b.p.treeGrid && b.p.data[i][j] && a(c).find("div.treeclick").trigger("click"), a(b).triggerHandler("jqGridKeyLeft", [b.p.selrow]),
                                a.isFunction(e.onLeftKey) && e.onLeftKey.call(b, b.p.selrow));
                            39 === d.keyCode && (b.p.treeGrid && !b.p.data[i][j] && a(c).find("div.treeclick").trigger("click"), a(b).triggerHandler("jqGridKeyRight", [b.p.selrow]), a.isFunction(e.onRightKey) && e.onRightKey.call(b, b.p.selrow))
                        } else 13 === d.keyCode ? (a(b).triggerHandler("jqGridKeyEnter", [b.p.selrow]), a.isFunction(e.onEnter) && e.onEnter.call(b, b.p.selrow)) : 32 === d.keyCode && (a(b).triggerHandler("jqGridKeySpace", [b.p.selrow]), a.isFunction(e.onSpace) && e.onSpace.call(b, b.p.selrow))
                })
            })
        },
        unbindKeys: function() {
            return this.each(function() {
                a(this).unbind("keydown")
            })
        },
        getLocalRow: function(d) {
            var e = !1,
                b;
            this.each(function() {
                void 0 !== d && (b = this.p._index[a.jgrid.stripPref(this.p.idPrefix, d)], 0 <= b && (e = this.p.data[b]))
            });
            return e
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.extend({
        getColProp: function(a) {
            var e = {},
                b = this[0];
            if (!b.grid) return !1;
            var b = b.p.colModel,
                f;
            for (f = 0; f < b.length; f++)
                if (b[f].name === a) {
                    e = b[f];
                    break
                }
            return e
        },
        setColProp: function(d, e) {
            return this.each(function() {
                if (this.grid && e) {
                    var b = this.p.colModel,
                        f;
                    for (f = 0; f < b.length; f++)
                        if (b[f].name === d) {
                            a.extend(!0, this.p.colModel[f], e);
                            break
                        }
                }
            })
        },
        sortGrid: function(a, e, b) {
            return this.each(function() {
                var f = -1,
                    c, h = !1;
                if (this.grid) {
                    a || (a = this.p.sortname);
                    for (c = 0; c < this.p.colModel.length; c++)
                        if (this.p.colModel[c].index ===
                            a || this.p.colModel[c].name === a) {
                            f = c;
                            !0 === this.p.frozenColumns && !0 === this.p.colModel[c].frozen && (h = this.grid.fhDiv.find("#" + this.p.id + "_" + a));
                            break
                        } - 1 !== f && (c = this.p.colModel[f].sortable, h || (h = this.grid.headers[f].el), "boolean" !== typeof c && (c = !0), "boolean" !== typeof e && (e = !1), c && this.sortData("jqgh_" + this.p.id + "_" + a, f, e, b, h))
                }
            })
        },
        clearBeforeUnload: function() {
            return this.each(function() {
                var d = this.grid;
                a.isFunction(d.emptyRows) && d.emptyRows.call(this, !0, !0);
                a(document).unbind("mouseup.jqGrid" + this.p.id);
                a(d.hDiv).unbind("mousemove");
                a(this).unbind();
                d.dragEnd = null;
                d.dragMove = null;
                d.dragStart = null;
                d.emptyRows = null;
                d.populate = null;
                d.populateVisible = null;
                d.scrollGrid = null;
                d.selectionPreserver = null;
                d.bDiv = null;
                d.cDiv = null;
                d.hDiv = null;
                d.cols = null;
                var e, b = d.headers.length;
                for (e = 0; e < b; e++) d.headers[e].el = null;
                this.grid = this.addJSONData = this.addXmlData = this.formatter = this.constructTr = this.setHeadCheckBox = this.refreshIndex = this.updatepager = this.sortData = this.formatCol = null
            })
        },
        GridDestroy: function() {
            return this.each(function() {
                if (this.grid) {
                    this.p.pager &&
                        a(this.p.pager).remove();
                    try {
                        a(this).jqGrid("clearBeforeUnload"), a("#gbox_" + a.jgrid.jqID(this.id)).remove()
                    } catch (d) {}
                }
            })
        },
        GridUnload: function() {
            return this.each(function() {
                if (this.grid) {
                    var d = a(this).attr("id"),
                        e = a(this).attr("class");
                    this.p.pager && a(this.p.pager).empty().removeClass("ui-state-default ui-jqgrid-pager ui-corner-bottom");
                    var b = document.createElement("table");
                    a(b).attr({
                        id: d
                    });
                    b.className = e;
                    d = a.jgrid.jqID(this.id);
                    a(b).removeClass("ui-jqgrid-btable");
                    1 === a(this.p.pager).parents("#gbox_" +
                        d).length ? (a(b).insertBefore("#gbox_" + d).show(), a(this.p.pager).insertBefore("#gbox_" + d)) : a(b).insertBefore("#gbox_" + d).show();
                    a(this).jqGrid("clearBeforeUnload");
                    a("#gbox_" + d).remove()
                }
            })
        },
        setGridState: function(d) {
            return this.each(function() {
                this.grid && ("hidden" === d ? (a(".ui-jqgrid-bdiv, .ui-jqgrid-hdiv", "#gview_" + a.jgrid.jqID(this.p.id)).slideUp("fast"), this.p.pager && a(this.p.pager).slideUp("fast"), this.p.toppager && a(this.p.toppager).slideUp("fast"), !0 === this.p.toolbar[0] && ("both" === this.p.toolbar[1] &&
                    a(this.grid.ubDiv).slideUp("fast"), a(this.grid.uDiv).slideUp("fast")), this.p.footerrow && a(".ui-jqgrid-sdiv", "#gbox_" + a.jgrid.jqID(this.p.id)).slideUp("fast"), a(".ui-jqgrid-titlebar-close span", this.grid.cDiv).removeClass("ui-icon-circle-triangle-n").addClass("ui-icon-circle-triangle-s"), this.p.gridstate = "hidden") : "visible" === d && (a(".ui-jqgrid-hdiv, .ui-jqgrid-bdiv", "#gview_" + a.jgrid.jqID(this.p.id)).slideDown("fast"), this.p.pager && a(this.p.pager).slideDown("fast"), this.p.toppager && a(this.p.toppager).slideDown("fast"), !0 === this.p.toolbar[0] && ("both" === this.p.toolbar[1] && a(this.grid.ubDiv).slideDown("fast"), a(this.grid.uDiv).slideDown("fast")), this.p.footerrow && a(".ui-jqgrid-sdiv", "#gbox_" + a.jgrid.jqID(this.p.id)).slideDown("fast"), a(".ui-jqgrid-titlebar-close span", this.grid.cDiv).removeClass("ui-icon-circle-triangle-s").addClass("ui-icon-circle-triangle-n"), this.p.gridstate = "visible"))
            })
        },
        filterToolbar: function(d) {
            d = a.extend({
                autosearch: !0,
                searchOnEnter: !0,
                beforeSearch: null,
                afterSearch: null,
                beforeClear: null,
                afterClear: null,
                searchurl: "",
                stringResult: !1,
                groupOp: "AND",
                defaultSearch: "bw",
                searchOperators: !1,
                resetIcon: "x",
                operands: {
                    eq: "==",
                    ne: "!",
                    lt: "<",
                    le: "<=",
                    gt: ">",
                    ge: ">=",
                    bw: "^",
                    bn: "!^",
                    "in": "=",
                    ni: "!=",
                    ew: "|",
                    en: "!@",
                    cn: "~",
                    nc: "!~",
                    nu: "#",
                    nn: "!#"
                }
            }, a.jgrid.search, d || {});
            return this.each(function() {
                var e = this;
                if (!this.ftoolbar) {
                    var b = function() {
                            var b = {},
                                c = 0,
                                f, h, m = {},
                                o;
                            a.each(e.p.colModel, function() {
                                var l = a("#gs_" + a.jgrid.jqID(this.name), !0 === this.frozen && !0 === e.p.frozenColumns ? e.grid.fhDiv : e.grid.hDiv);
                                h = this.index ||
                                    this.name;
                                o = d.searchOperators ? l.parent().prev().children("a").attr("soper") || d.defaultSearch : this.searchoptions && this.searchoptions.sopt ? this.searchoptions.sopt[0] : "select" === this.stype ? "eq" : d.defaultSearch;
                                if ((f = "custom" === this.stype && a.isFunction(this.searchoptions.custom_value) && 0 < l.length && "SPAN" === l[0].nodeName.toUpperCase() ? this.searchoptions.custom_value.call(e, l.children(".customelement:first"), "get") : l.val()) || "nu" === o || "nn" === o) b[h] = f, m[h] = o, c++;
                                else try {
                                    delete e.p.postData[h]
                                } catch (n) {}
                            });
                            var n = 0 < c ? !0 : !1;
                            if (!0 === d.stringResult || "local" === e.p.datatype || !0 === d.searchOperators) {
                                var l = '{"groupOp":"' + d.groupOp + '","rules":[',
                                    p = 0;
                                a.each(b, function(a, b) {
                                    0 < p && (l += ",");
                                    l += '{"field":"' + a + '",';
                                    l += '"op":"' + m[a] + '",';
                                    l += '"data":"' + (b + "").replace(/\\/g, "\\\\").replace(/\"/g, '\\"') + '"}';
                                    p++
                                });
                                l += "]}";
                                a.extend(e.p.postData, {
                                    filters: l
                                });
                                a.each(["searchField", "searchString", "searchOper"], function(a, b) {
                                    e.p.postData.hasOwnProperty(b) && delete e.p.postData[b]
                                })
                            } else a.extend(e.p.postData, b);
                            var r;
                            e.p.searchurl &&
                                (r = e.p.url, a(e).jqGrid("setGridParam", {
                                    url: e.p.searchurl
                                }));
                            var q = "stop" === a(e).triggerHandler("jqGridToolbarBeforeSearch") ? !0 : !1;
                            !q && a.isFunction(d.beforeSearch) && (q = d.beforeSearch.call(e));
                            q || a(e).jqGrid("setGridParam", {
                                search: n
                            }).trigger("reloadGrid", [{
                                page: 1
                            }]);
                            r && a(e).jqGrid("setGridParam", {
                                url: r
                            });
                            a(e).triggerHandler("jqGridToolbarAfterSearch");
                            a.isFunction(d.afterSearch) && d.afterSearch.call(e)
                        },
                        f = function(c, f, h) {
                            a("#sopt_menu").remove();
                            var f = parseInt(f, 10),
                                h = parseInt(h, 10) + 18,
                                f = '<ul id="sopt_menu" class="ui-search-menu" role="menu" tabindex="0" style="font-size:' +
                                (a(".ui-jqgrid-view").css("font-size") || "11px") + ";left:" + f + "px;top:" + h + 'px;">',
                                h = a(c).attr("soper"),
                                k, m = [],
                                o, n = 0,
                                l = a(c).attr("colname");
                            for (k = e.p.colModel.length; n < k && e.p.colModel[n].name !== l;) n++;
                            n = e.p.colModel[n];
                            l = a.extend({}, n.searchoptions);
                            l.sopt || (l.sopt = [], l.sopt[0] = "select" === n.stype ? "eq" : d.defaultSearch);
                            a.each(d.odata, function() {
                                m.push(this.oper)
                            });
                            for (n = 0; n < l.sopt.length; n++) o = a.inArray(l.sopt[n], m), -1 !== o && (k = h === d.odata[o].oper ? "ui-state-highlight" : "", f += '<li class="ui-menu-item ' + k +
                                '" role="presentation"><a class="ui-corner-all g-menu-item" tabindex="0" role="menuitem" value="' + d.odata[o].oper + '" oper="' + d.operands[d.odata[o].oper] + '"><table cellspacing="0" cellpadding="0" border="0"><tr><td width="25px">' + d.operands[d.odata[o].oper] + "</td><td>" + d.odata[o].text + "</td></tr></table></a></li>");
                            a("body").append(f + "</ul>");
                            a("#sopt_menu").addClass("ui-menu ui-widget ui-widget-content ui-corner-all");
                            a("#sopt_menu > li > a").hover(function() {
                                a(this).addClass("ui-state-hover")
                            }, function() {
                                a(this).removeClass("ui-state-hover")
                            }).click(function() {
                                var f =
                                    a(this).attr("value"),
                                    i = a(this).attr("oper");
                                a(e).triggerHandler("jqGridToolbarSelectOper", [f, i, c]);
                                a("#sopt_menu").hide();
                                a(c).text(i).attr("soper", f);
                                if (d.autosearch === true) {
                                    i = a(c).parent().next().children()[0];
                                    (a(i).val() || f === "nu" || f === "nn") && b()
                                }
                            })
                        },
                        c = a("<tr class='ui-search-toolbar' role='rowheader'></tr>"),
                        h;
                    a.each(e.p.colModel, function(f) {
                        var i = this,
                            j, k;
                        k = "";
                        var m = "=",
                            o, n = a("<th role='columnheader' class='ui-state-default ui-th-column ui-th-" + e.p.direction + "'></th>"),
                            l = a("<div style='position:relative;height:auto;padding-right:0.3em;padding-left:0.3em;'></div>"),
                            p = a("<table class='ui-search-table' cellspacing='0'><tr><td class='ui-search-oper'></td><td class='ui-search-input'></td><td class='ui-search-clear'></td></tr></table>");
                        !0 === this.hidden && a(n).css("display", "none");
                        this.search = !1 === this.search ? !1 : !0;
                        void 0 === this.stype && (this.stype = "text");
                        j = a.extend({}, this.searchoptions || {});
                        if (this.search) {
                            if (d.searchOperators) {
                                k = j.sopt ? j.sopt[0] : "select" === i.stype ? "eq" : d.defaultSearch;
                                for (o = 0; o < d.odata.length; o++)
                                    if (d.odata[o].oper === k) {
                                        m = d.operands[k] || "";
                                        break
                                    }
                                k =
                                    "<a title='" + (null != j.searchtitle ? j.searchtitle : d.operandTitle) + "' style='padding-right: 0.5em;' soper='" + k + "' class='soptclass' colname='" + this.name + "'>" + m + "</a>"
                            }
                            a("td:eq(0)", p).attr("colindex", f).append(k);
                            void 0 === j.clearSearch && (j.clearSearch = !0);
                            j.clearSearch ? (k = d.resetTitle || "Clear Search Value", a("td:eq(2)", p).append("<a title='" + k + "' style='padding-right: 0.3em;padding-left: 0.3em;' class='clearsearchclass'>" + d.resetIcon + "</a>")) : a("td:eq(2)", p).hide();
                            switch (this.stype) {
                                case "select":
                                    if (k =
                                        this.surl || j.dataUrl) a(l).append(p), a.ajax(a.extend({
                                        url: k,
                                        dataType: "html",
                                        success: function(c) {
                                            if (j.buildSelect !== void 0)(c = j.buildSelect(c)) && a("td:eq(1)", p).append(c);
                                            else a("td:eq(1)", p).append(c);
                                            j.defaultValue !== void 0 && a("select", l).val(j.defaultValue);
                                            a("select", l).attr({
                                                name: i.index || i.name,
                                                id: "gs_" + i.name
                                            });
                                            j.attr && a("select", l).attr(j.attr);
                                            a("select", l).css({
                                                width: "100%"
                                            });
                                            a.jgrid.bindEv.call(e, a("select", l)[0], j);
                                            d.autosearch === true && a("select", l).change(function() {
                                                b();
                                                return false
                                            });
                                            c = null
                                        }
                                    }, a.jgrid.ajaxOptions, e.p.ajaxSelectOptions || {}));
                                    else {
                                        var r, q, s;
                                        i.searchoptions ? (r = void 0 === i.searchoptions.value ? "" : i.searchoptions.value, q = void 0 === i.searchoptions.separator ? ":" : i.searchoptions.separator, s = void 0 === i.searchoptions.delimiter ? ";" : i.searchoptions.delimiter) : i.editoptions && (r = void 0 === i.editoptions.value ? "" : i.editoptions.value, q = void 0 === i.editoptions.separator ? ":" : i.editoptions.separator, s = void 0 === i.editoptions.delimiter ? ";" : i.editoptions.delimiter);
                                        if (r) {
                                            var t = document.createElement("select");
                                            t.style.width = "100%";
                                            a(t).attr({
                                                name: i.index || i.name,
                                                id: "gs_" + i.name
                                            });
                                            var w;
                                            if ("string" === typeof r) {
                                                k = r.split(s);
                                                for (w = 0; w < k.length; w++) r = k[w].split(q), s = document.createElement("option"), s.value = r[0], s.innerHTML = r[1], t.appendChild(s)
                                            } else if ("object" === typeof r)
                                                for (w in r) r.hasOwnProperty(w) && (s = document.createElement("option"), s.value = w, s.innerHTML = r[w], t.appendChild(s));
                                            void 0 !== j.defaultValue && a(t).val(j.defaultValue);
                                            j.attr && a(t).attr(j.attr);
                                            a(l).append(p);
                                            a.jgrid.bindEv.call(e, t, j);
                                            a("td:eq(1)",
                                                p).append(t);
                                            !0 === d.autosearch && a(t).change(function() {
                                                b();
                                                return false
                                            })
                                        }
                                    }
                                    break;
                                case "text":
                                    q = void 0 !== j.defaultValue ? j.defaultValue : "";
                                    a("td:eq(1)", p).append("<input type='text' style='width:100%;padding:0px;' name='" + (i.index || i.name) + "' id='gs_" + i.name + "' value='" + q + "'/>");
                                    a(l).append(p);
                                    j.attr && a("input", l).attr(j.attr);
                                    a.jgrid.bindEv.call(e, a("input", l)[0], j);
                                    !0 === d.autosearch && (d.searchOnEnter ? a("input", l).keypress(function(a) {
                                            if ((a.charCode || a.keyCode || 0) === 13) {
                                                b();
                                                return false
                                            }
                                            return this
                                        }) :
                                        a("input", l).keydown(function(a) {
                                            switch (a.which) {
                                                case 13:
                                                    return false;
                                                case 9:
                                                case 16:
                                                case 37:
                                                case 38:
                                                case 39:
                                                case 40:
                                                case 27:
                                                    break;
                                                default:
                                                    h && clearTimeout(h);
                                                    h = setTimeout(function() {
                                                        b()
                                                    }, 500)
                                            }
                                        }));
                                    break;
                                case "custom":
                                    a("td:eq(1)", p).append("<span style='width:95%;padding:0px;' name='" + (i.index || i.name) + "' id='gs_" + i.name + "'/>");
                                    a(l).append(p);
                                    try {
                                        if (a.isFunction(j.custom_element))
                                            if (t = j.custom_element.call(e, void 0 !== j.defaultValue ? j.defaultValue : "", j)) t = a(t).addClass("customelement"), a(l).find("span[name='" +
                                                (i.index || i.name) + "']").append(t);
                                            else throw "e2";
                                        else throw "e1";
                                    } catch (v) {
                                        "e1" === v && a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_element' " + a.jgrid.edit.msg.nodefined, a.jgrid.edit.bClose), "e2" === v ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_element' " + a.jgrid.edit.msg.novalue, a.jgrid.edit.bClose) : a.jgrid.info_dialog(a.jgrid.errors.errcap, "string" === typeof v ? v : v.message, a.jgrid.edit.bClose)
                                    }
                            }
                        }
                        a(n).append(l);
                        a(c).append(n);
                        d.searchOperators || a("td:eq(0)", p).hide()
                    });
                    a("table thead",
                        e.grid.hDiv).append(c);
                    d.searchOperators && (a(".soptclass", c).click(function(b) {
                        var c = a(this).offset();
                        f(this, c.left, c.top);
                        b.stopPropagation()
                    }), a("body").on("click", function(b) {
                        "soptclass" !== b.target.className && a("#sopt_menu").hide()
                    }));
                    a(".clearsearchclass", c).click(function() {
                        var c = a(this).parents("tr:first"),
                            f = parseInt(a("td.ui-search-oper", c).attr("colindex"), 10),
                            h = a.extend({}, e.p.colModel[f].searchoptions || {}),
                            h = h.defaultValue ? h.defaultValue : "";
                        e.p.colModel[f].stype === "select" ? h ? a("td.ui-search-input select",
                            c).val(h) : a("td.ui-search-input select", c)[0].selectedIndex = 0 : a("td.ui-search-input input", c).val(h);
                        d.autosearch === true && b()
                    });
                    this.ftoolbar = !0;
                    this.triggerToolbar = b;
                    this.clearToolbar = function(b) {
                        var c = {},
                            f = 0,
                            h, b = typeof b !== "boolean" ? true : b;
                        a.each(e.p.colModel, function() {
                            var b, d = a("#gs_" + a.jgrid.jqID(this.name), this.frozen === true && e.p.frozenColumns === true ? e.grid.fhDiv : e.grid.hDiv);
                            if (this.searchoptions && this.searchoptions.defaultValue !== void 0) b = this.searchoptions.defaultValue;
                            h = this.index || this.name;
                            switch (this.stype) {
                                case "select":
                                    d.find("option").each(function(c) {
                                        if (c === 0) this.selected = true;
                                        if (a(this).val() === b) {
                                            this.selected = true;
                                            return false
                                        }
                                    });
                                    if (b !== void 0) {
                                        c[h] = b;
                                        f++
                                    } else try {
                                        delete e.p.postData[h]
                                    } catch (g) {}
                                    break;
                                case "text":
                                    d.val(b || "");
                                    if (b !== void 0) {
                                        c[h] = b;
                                        f++
                                    } else try {
                                        delete e.p.postData[h]
                                    } catch (l) {}
                                    break;
                                case "custom":
                                    a.isFunction(this.searchoptions.custom_value) && (d.length > 0 && d[0].nodeName.toUpperCase() === "SPAN") && this.searchoptions.custom_value.call(e, d.children(".customelement:first"),
                                        "set", b || "")
                            }
                        });
                        var m = f > 0 ? true : false;
                        e.p.resetsearch = true;
                        if (d.stringResult === true || e.p.datatype === "local") {
                            var o = '{"groupOp":"' + d.groupOp + '","rules":[',
                                n = 0;
                            a.each(c, function(a, b) {
                                n > 0 && (o = o + ",");
                                o = o + ('{"field":"' + a + '",');
                                o = o + '"op":"eq",';
                                o = o + ('"data":"' + (b + "").replace(/\\/g, "\\\\").replace(/\"/g, '\\"') + '"}');
                                n++
                            });
                            o = o + "]}";
                            a.extend(e.p.postData, {
                                filters: o
                            });
                            a.each(["searchField", "searchString", "searchOper"], function(a, b) {
                                e.p.postData.hasOwnProperty(b) && delete e.p.postData[b]
                            })
                        } else a.extend(e.p.postData,
                            c);
                        var l;
                        if (e.p.searchurl) {
                            l = e.p.url;
                            a(e).jqGrid("setGridParam", {
                                url: e.p.searchurl
                            })
                        }
                        var p = a(e).triggerHandler("jqGridToolbarBeforeClear") === "stop" ? true : false;
                        !p && a.isFunction(d.beforeClear) && (p = d.beforeClear.call(e));
                        p || b && a(e).jqGrid("setGridParam", {
                            search: m
                        }).trigger("reloadGrid", [{
                            page: 1
                        }]);
                        l && a(e).jqGrid("setGridParam", {
                            url: l
                        });
                        a(e).triggerHandler("jqGridToolbarAfterClear");
                        a.isFunction(d.afterClear) && d.afterClear()
                    };
                    this.toggleToolbar = function() {
                        var b = a("tr.ui-search-toolbar", e.grid.hDiv),
                            c =
                            e.p.frozenColumns === true ? a("tr.ui-search-toolbar", e.grid.fhDiv) : false;
                        if (b.css("display") === "none") {
                            b.show();
                            c && c.show()
                        } else {
                            b.hide();
                            c && c.hide()
                        }
                    }
                }
            })
        },
        destroyFilterToolbar: function() {
            return this.each(function() {
                this.ftoolbar && (this.toggleToolbar = this.clearToolbar = this.triggerToolbar = null, this.ftoolbar = !1, a(this.grid.hDiv).find("table thead tr.ui-search-toolbar").remove())
            })
        },
        destroyGroupHeader: function(d) {
            void 0 === d && (d = !0);
            return this.each(function() {
                var e, b, f, c, h, g;
                b = this.grid;
                var i = a("table.ui-jqgrid-htable thead",
                        b.hDiv),
                    j = this.p.colModel;
                if (b) {
                    a(this).unbind(".setGroupHeaders");
                    e = a("<tr>", {
                        role: "rowheader"
                    }).addClass("ui-jqgrid-labels");
                    c = b.headers;
                    b = 0;
                    for (f = c.length; b < f; b++) {
                        h = j[b].hidden ? "none" : "";
                        h = a(c[b].el).width(c[b].width).css("display", h);
                        try {
                            h.removeAttr("rowSpan")
                        } catch (k) {
                            h.attr("rowSpan", 1)
                        }
                        e.append(h);
                        g = h.children("span.ui-jqgrid-resize");
                        0 < g.length && (g[0].style.height = "");
                        h.children("div")[0].style.top = ""
                    }
                    a(i).children("tr.ui-jqgrid-labels").remove();
                    a(i).prepend(e);
                    !0 === d && a(this).jqGrid("setGridParam", {
                        groupHeader: null
                    })
                }
            })
        },
        setGroupHeaders: function(d) {
            d = a.extend({
                useColSpanStyle: !1,
                groupHeaders: []
            }, d || {});
            return this.each(function() {
                this.p.groupHeader = d;
                var e, b, f = 0,
                    c, h, g, i, j, k = this.p.colModel,
                    m = k.length,
                    o = this.grid.headers,
                    n = a("table.ui-jqgrid-htable", this.grid.hDiv),
                    l = n.children("thead").children("tr.ui-jqgrid-labels:last").addClass("jqg-second-row-header");
                c = n.children("thead");
                var p = n.find(".jqg-first-row-header");
                void 0 === p[0] ? p = a("<tr>", {
                    role: "row",
                    "aria-hidden": "true"
                }).addClass("jqg-first-row-header").css("height",
                    "auto") : p.empty();
                var r, q = function(a, b) {
                    var c = b.length,
                        d;
                    for (d = 0; d < c; d++)
                        if (b[d].startColumnName === a) return d;
                    return -1
                };
                a(this).prepend(c);
                c = a("<tr>", {
                    role: "rowheader"
                }).addClass("ui-jqgrid-labels jqg-third-row-header");
                for (e = 0; e < m; e++)
                    if (g = o[e].el, i = a(g), b = k[e], h = {
                        height: "0px",
                        width: o[e].width + "px",
                        display: b.hidden ? "none" : ""
                    }, a("<th>", {
                        role: "gridcell"
                    }).css(h).addClass("ui-first-th-" + this.p.direction).appendTo(p), g.style.width = "", h = q(b.name, d.groupHeaders), 0 <= h) {
                        h = d.groupHeaders[h];
                        f = h.numberOfColumns;
                        j = h.titleText;
                        for (h = b = 0; h < f && e + h < m; h++) k[e + h].hidden || b++;
                        h = a("<th>").attr({
                            role: "columnheader"
                        }).addClass("ui-state-default ui-th-column-header ui-th-" + this.p.direction).css({
                            height: "22px",
                            "border-top": "0 none"
                        }).html(j);
                        0 < b && h.attr("colspan", "" + b);
                        this.p.headertitles && h.attr("title", h.text());
                        0 === b && h.hide();
                        i.before(h);
                        c.append(g);
                        f -= 1
                    } else 0 === f ? d.useColSpanStyle ? i.attr("rowspan", "2") : (a("<th>", {
                        role: "columnheader"
                    }).addClass("ui-state-default ui-th-column-header ui-th-" + this.p.direction).css({
                        display: b.hidden ?
                            "none" : "",
                        "border-top": "0 none"
                    }).insertBefore(i), c.append(g)) : (c.append(g), f--);
                k = a(this).children("thead");
                k.prepend(p);
                c.insertAfter(l);
                n.append(k);
                d.useColSpanStyle && (n.find("span.ui-jqgrid-resize").each(function() {
                    var b = a(this).parent();
                    b.is(":visible") && (this.style.cssText = "height: " + b.height() + "px !important; cursor: col-resize;")
                }), n.find("div.ui-jqgrid-sortable").each(function() {
                    var b = a(this),
                        c = b.parent();
                    c.is(":visible") && c.is(":has(span.ui-jqgrid-resize)") && b.css("top", (c.height() - b.outerHeight()) /
                        2 + "px")
                }));
                r = k.find("tr.jqg-first-row-header");
                a(this).bind("jqGridResizeStop.setGroupHeaders", function(a, b, c) {
                    r.find("th").eq(c).width(b)
                })
            })
        },
        setFrozenColumns: function() {
            return this.each(function() {
                if (this.grid) {
                    var d = this,
                        e = d.p.colModel,
                        b = 0,
                        f = e.length,
                        c = -1,
                        h = !1;
                    if (!(!0 === d.p.subGrid || !0 === d.p.treeGrid || !0 === d.p.cellEdit || d.p.sortable || d.p.scroll)) {
                        d.p.rownumbers && b++;
                        for (d.p.multiselect && b++; b < f;) {
                            if (!0 === e[b].frozen) h = !0, c = b;
                            else break;
                            b++
                        }
                        if (0 <= c && h) {
                            e = d.p.caption ? a(d.grid.cDiv).outerHeight() :
                                0;
                            b = a(".ui-jqgrid-htable", "#gview_" + a.jgrid.jqID(d.p.id)).height()+1;
                            d.p.toppager && (e += a(d.grid.topDiv).outerHeight());
                            !0 === d.p.toolbar[0] && "bottom" !== d.p.toolbar[1] && (e += a(d.grid.uDiv).outerHeight());
                            d.grid.fhDiv = a('<div style="position:absolute;left:0px;top:' + e + "px;height:" + b + 'px;" class="frozen-div ui-state-default ui-jqgrid-hdiv"></div>');
                            d.grid.fbDiv = a('<div style="position:absolute;left:0px;top:' + (parseInt(e, 10) + parseInt(b, 10) + 1) + 'px;overflow-y:hidden" class="frozen-bdiv ui-jqgrid-bdiv"></div>');
                            a("#gview_" + a.jgrid.jqID(d.p.id)).append(d.grid.fhDiv);
                            e = a(".ui-jqgrid-htable", "#gview_" + a.jgrid.jqID(d.p.id)).clone(!0);
                            if (d.p.groupHeader) {
                                a("tr.jqg-first-row-header, tr.jqg-third-row-header", e).each(function() {
                                    a("th:gt(" + c + ")", this).remove()
                                });
                                var g = -1,
                                    i = -1,
                                    j, k;
                                a("tr.jqg-second-row-header th", e).each(function() {
                                    j = parseInt(a(this).attr("colspan"), 10);
                                    if (k = parseInt(a(this).attr("rowspan"), 10)) g++, i++;
                                    j && (g += j, i++);
                                    if (g === c) return !1
                                });
                                g !== c && (i = c);
                                a("tr.jqg-second-row-header", e).each(function() {
                                    a("th:gt(" +
                                        i + ")", this).remove()
                                })
                            } else a("tr", e).each(function() {
                                a("th:gt(" + c + ")", this).remove()
                            });
                            a(e).width(1);
                            a(d.grid.fhDiv).append(e).mousemove(function(a) {
                                if (d.grid.resizing) return d.grid.dragMove(a), !1
                            });
                            a(d).bind("jqGridResizeStop.setFrozenColumns", function(b, c, e) {
                                b = a(".ui-jqgrid-htable", d.grid.fhDiv);
                                a("th:eq(" + e + ")", b).width(c);
                                b = a(".ui-jqgrid-btable", d.grid.fbDiv);
                                a("tr:first td:eq(" + e + ")", b).width(c)
                            });
                            a(d).bind("jqGridSortCol.setFrozenColumns", function(b, c, e) {
                                b = a("tr.ui-jqgrid-labels:last th:eq(" +
                                    d.p.lastsort + ")", d.grid.fhDiv);
                                c = a("tr.ui-jqgrid-labels:last th:eq(" + e + ")", d.grid.fhDiv);
                                a("span.ui-grid-ico-sort", b).addClass("ui-state-disabled");
                                a(b).attr("aria-selected", "false");
                                a("span.ui-icon-" + d.p.sortorder, c).removeClass("ui-state-disabled");
                                a(c).attr("aria-selected", "true");
                                !d.p.viewsortcols[0] && d.p.lastsort !== e && (a("span.s-ico", b).hide(), a("span.s-ico", c).show())
                            });
                            a("#gview_" + a.jgrid.jqID(d.p.id)).append(d.grid.fbDiv);
                            a(d.grid.bDiv).scroll(function() {
                                a(d.grid.fbDiv).scrollTop(a(this).scrollTop())
                            });
                            !0 === d.p.hoverrows && a("#" + a.jgrid.jqID(d.p.id)).unbind("mouseover").unbind("mouseout");
                            a(d).bind("jqGridAfterGridComplete.setFrozenColumns", function() {
                                a("#" + a.jgrid.jqID(d.p.id) + "_frozen").remove();
                                a(d.grid.fbDiv).height(a(d.grid.bDiv).height() - 16);
                                var b = a("#" + a.jgrid.jqID(d.p.id)).clone(!0);
                                a("tr[role=row]", b).each(function() {
                                    a("td[role=gridcell]:gt(" + c + ")", this).remove()
                                });
                                a(b).width(1).attr("id", d.p.id + "_frozen");
                                a(d.grid.fbDiv).append(b);
                                !0 === d.p.hoverrows && (a("tr.jqgrow", b).hover(function() {
                                    a(this).addClass("ui-state-hover");
                                    a("#" + a.jgrid.jqID(this.id), "#" + a.jgrid.jqID(d.p.id)).addClass("ui-state-hover")
                                }, function() {
                                    a(this).removeClass("ui-state-hover");
                                    a("#" + a.jgrid.jqID(this.id), "#" + a.jgrid.jqID(d.p.id)).removeClass("ui-state-hover")
                                }), a("tr.jqgrow", "#" + a.jgrid.jqID(d.p.id)).hover(function() {
                                    a(this).addClass("ui-state-hover");
                                    a("#" + a.jgrid.jqID(this.id), "#" + a.jgrid.jqID(d.p.id) + "_frozen").addClass("ui-state-hover")
                                }, function() {
                                    a(this).removeClass("ui-state-hover");
                                    a("#" + a.jgrid.jqID(this.id), "#" + a.jgrid.jqID(d.p.id) +
                                        "_frozen").removeClass("ui-state-hover")
                                }));
                                b = null
                            });
                            d.grid.hDiv.loading || a(d).triggerHandler("jqGridAfterGridComplete");
                            d.p.frozenColumns = !0
                        }
                    }
                }
            })
        },
        destroyFrozenColumns: function() {
            return this.each(function() {
                if (this.grid && !0 === this.p.frozenColumns) {
                    a(this.grid.fhDiv).remove();
                    a(this.grid.fbDiv).remove();
                    this.grid.fhDiv = null;
                    this.grid.fbDiv = null;
                    a(this).unbind(".setFrozenColumns");
                    if (!0 === this.p.hoverrows) {
                        var d;
                        a("#" + a.jgrid.jqID(this.p.id)).bind("mouseover", function(e) {
                            d = a(e.target).closest("tr.jqgrow");
                            "ui-subgrid" !== a(d).attr("class") && a(d).addClass("ui-state-hover")
                        }).bind("mouseout", function(e) {
                            d = a(e.target).closest("tr.jqgrow");
                            a(d).removeClass("ui-state-hover")
                        })
                    }
                    this.p.frozenColumns = !1
                }
            })
        }
    })
})(jQuery);
(function(a) {
    a.fn.jqm = function(b) {
        var c = {
            overlay: 50,
            closeoverlay: !0,
            overlayClass: "jqmOverlay",
            closeClass: "jqmClose",
            trigger: ".jqModal",
            ajax: f,
            ajaxText: "",
            target: f,
            modal: f,
            toTop: f,
            onShow: f,
            onHide: f,
            onLoad: f
        };
        return this.each(function() {
            if (this._jqm) return e[this._jqm].c = a.extend({}, e[this._jqm].c, b);
            d++;
            this._jqm = d;
            e[d] = {
                c: a.extend(c, a.jqm.params, b),
                a: f,
                w: a(this).addClass("jqmID" + d),
                s: d
            };
            c.trigger && a(this).jqmAddTrigger(c.trigger)
        })
    };
    a.fn.jqmAddClose = function(a) {
        return i(this, a, "jqmHide")
    };
    a.fn.jqmAddTrigger =
        function(a) {
            return i(this, a, "jqmShow")
        };
    a.fn.jqmShow = function(b) {
        return this.each(function() {
            a.jqm.open(this._jqm, b)
        })
    };
    a.fn.jqmHide = function(b) {
        return this.each(function() {
            a.jqm.close(this._jqm, b)
        })
    };
    a.jqm = {
        hash: {},
        open: function(d, g) {
            var i = e[d],
                o = i.c,
                n = "." + o.closeClass,
                l = parseInt(i.w.css("z-index")),
                l = 0 < l ? l : 3E3,
                p = a("<div></div>").css({
                    height: "100%",
                    width: "100%",
                    position: "fixed",
                    left: 0,
                    top: 0,
                    "z-index": l - 1,
                    opacity: o.overlay / 100
                });
            if (i.a) return f;
            i.t = g;
            i.a = !0;
            i.w.css("z-index", l);
            o.modal ? (b[0] || setTimeout(function() {
                    h("bind")
                },
                1), b.push(d)) : 0 < o.overlay ? o.closeoverlay && i.w.jqmAddClose(p) : p = f;
            i.o = p ? p.addClass(o.overlayClass).prependTo("body") : f;
            o.ajax ? (l = o.target || i.w, p = o.ajax, l = "string" == typeof l ? a(l, i.w) : a(l), p = "@" == p.substr(0, 1) ? a(g).attr(p.substring(1)) : p, l.html(o.ajaxText).load(p, function() {
                o.onLoad && o.onLoad.call(this, i);
                n && i.w.jqmAddClose(a(n, i.w));
                c(i)
            })) : n && i.w.jqmAddClose(a(n, i.w));
            o.toTop && i.o && i.w.before('<span id="jqmP' + i.w[0]._jqm + '"></span>').insertAfter(i.o);
            o.onShow ? o.onShow(i) : i.w.show();
            c(i);
            return f
        },
        close: function(c) {
            c = e[c];
            if (!c.a) return f;
            c.a = f;
            b[0] && (b.pop(), b[0] || h("unbind"));
            c.c.toTop && c.o && a("#jqmP" + c.w[0]._jqm).after(c.w).remove();
            if (c.c.onHide) c.c.onHide(c);
            else c.w.hide(), c.o && c.o.remove();
            return f
        },
        params: {}
    };
    var d = 0,
        e = a.jqm.hash,
        b = [],
        f = !1,
        c = function(b) {
            try {
                a(":input:visible", b.w)[0].focus()
            } catch (c) {}
        },
        h = function(b) {
            a(document)[b]("keypress", g)[b]("keydown", g)[b]("mousedown", g)
        },
        g = function(d) {
            var f = e[b[b.length - 1]],
                g = !a(d.target).parents(".jqmID" + f.s)[0];
            g && (a(".jqmID" + f.s).each(function() {
                var b =
                    a(this),
                    c = b.offset();
                if (c.top <= d.pageY && d.pageY <= c.top + b.height() && c.left <= d.pageX && d.pageX <= c.left + b.width()) return g = !1
            }), c(f));
            return !g
        },
        i = function(b, c, d) {
            return b.each(function() {
                var b = this._jqm;
                a(c).each(function() {
                    this[d] || (this[d] = [], a(this).click(function() {
                        for (var a in {
                            jqmShow: 1,
                            jqmHide: 1
                        })
                            for (var b in this[a])
                                if (e[this[a][b]]) e[this[a][b]].w[a](this);
                        return f
                    }));
                    this[d].push(b)
                })
            })
        }
})(jQuery);
(function(a) {
    a.fn.jqDrag = function(a) {
        return h(this, a, "d")
    };
    a.fn.jqResize = function(a, b) {
        return h(this, a, "r", b)
    };
    a.jqDnR = {
        dnr: {},
        e: 0,
        drag: function(a) {
            "d" == e.k ? b.css({
                left: e.X + a.pageX - e.pX,
                top: e.Y + a.pageY - e.pY
            }) : (b.css({
                width: Math.max(a.pageX - e.pX + e.W, 0),
                height: Math.max(a.pageY - e.pY + e.H, 0)
            }), c && f.css({
                width: Math.max(a.pageX - c.pX + c.W, 0),
                height: Math.max(a.pageY - c.pY + c.H, 0)
            }));
            return !1
        },
        stop: function() {
            a(document).unbind("mousemove", d.drag).unbind("mouseup", d.stop)
        }
    };
    var d = a.jqDnR,
        e = d.dnr,
        b = d.e,
        f, c, h = function(d,
            h, m, o) {
            return d.each(function() {
                h = h ? a(h, d) : d;
                h.bind("mousedown", {
                    e: d,
                    k: m
                }, function(d) {
                    var h = d.data,
                        j = {};
                    b = h.e;
                    f = o ? a(o) : !1;
                    if ("relative" != b.css("position")) try {
                        b.position(j)
                    } catch (k) {}
                    e = {
                        X: j.left || g("left") || 0,
                        Y: j.top || g("top") || 0,
                        W: g("width") || b[0].scrollWidth || 0,
                        H: g("height") || b[0].scrollHeight || 0,
                        pX: d.pageX,
                        pY: d.pageY,
                        k: h.k
                    };
                    c = f && "d" != h.k ? {
                        X: j.left || i("left") || 0,
                        Y: j.top || i("top") || 0,
                        W: f[0].offsetWidth || i("width") || 0,
                        H: f[0].offsetHeight || i("height") || 0,
                        pX: d.pageX,
                        pY: d.pageY,
                        k: h.k
                    } : !1;
                    if (a("input.hasDatepicker",
                        b[0])[0]) try {
                        a("input.hasDatepicker", b[0]).datepicker("hide")
                    } catch (m) {}
                    a(document).mousemove(a.jqDnR.drag).mouseup(a.jqDnR.stop);
                    return !1
                })
            })
        },
        g = function(a) {
            return parseInt(b.css(a), 10) || !1
        },
        i = function(a) {
            return parseInt(f.css(a), 10) || !1
        }
})(jQuery);
var xmlJsonClass = {
    xml2json: function(a, d) {
        9 === a.nodeType && (a = a.documentElement);
        var e = this.toJson(this.toObj(this.removeWhite(a)), a.nodeName, "\t");
        return "{\n" + d + (d ? e.replace(/\t/g, d) : e.replace(/\t|\n/g, "")) + "\n}"
    },
    json2xml: function(a, d) {
        var e = function(a, b, d) {
                var f = "",
                    j, k;
                if (a instanceof Array)
                    if (0 === a.length) f += d + "<" + b + ">__EMPTY_ARRAY_</" + b + ">\n";
                    else {
                        j = 0;
                        for (k = a.length; j < k; j += 1) var m = d + e(a[j], b, d + "\t") + "\n",
                            f = f + m
                    } else if ("object" === typeof a) {
                    j = !1;
                    f += d + "<" + b;
                    for (k in a) a.hasOwnProperty(k) && ("@" ===
                        k.charAt(0) ? f += " " + k.substr(1) + '="' + a[k].toString() + '"' : j = !0);
                    f += j ? ">" : "/>";
                    if (j) {
                        for (k in a) a.hasOwnProperty(k) && ("#text" === k ? f += a[k] : "#cdata" === k ? f += "<![CDATA[" + a[k] + "]]\>" : "@" !== k.charAt(0) && (f += e(a[k], k, d + "\t")));
                        f += ("\n" === f.charAt(f.length - 1) ? d : "") + "</" + b + ">"
                    }
                } else "function" === typeof a ? f += d + "<" + b + "><![CDATA[" + a + "]]\></" + b + ">" : (void 0 === a && (a = ""), f = '""' === a.toString() || 0 === a.toString().length ? f + (d + "<" + b + ">__EMPTY_STRING_</" + b + ">") : f + (d + "<" + b + ">" + a.toString() + "</" + b + ">"));
                return f
            },
            b = "",
            f;
        for (f in a) a.hasOwnProperty(f) &&
            (b += e(a[f], f, ""));
        return d ? b.replace(/\t/g, d) : b.replace(/\t|\n/g, "")
    },
    toObj: function(a) {
        var d = {},
            e = /function/i;
        if (1 === a.nodeType) {
            if (a.attributes.length) {
                var b;
                for (b = 0; b < a.attributes.length; b += 1) d["@" + a.attributes[b].nodeName] = (a.attributes[b].nodeValue || "").toString()
            }
            if (a.firstChild) {
                var f = b = 0,
                    c = !1,
                    h;
                for (h = a.firstChild; h; h = h.nextSibling) 1 === h.nodeType ? c = !0 : 3 === h.nodeType && h.nodeValue.match(/[^ \f\n\r\t\v]/) ? b += 1 : 4 === h.nodeType && (f += 1);
                if (c)
                    if (2 > b && 2 > f) {
                        this.removeWhite(a);
                        for (h = a.firstChild; h; h =
                            h.nextSibling) 3 === h.nodeType ? d["#text"] = this.escape(h.nodeValue) : 4 === h.nodeType ? e.test(h.nodeValue) ? d[h.nodeName] = [d[h.nodeName], h.nodeValue] : d["#cdata"] = this.escape(h.nodeValue) : d[h.nodeName] ? d[h.nodeName] instanceof Array ? d[h.nodeName][d[h.nodeName].length] = this.toObj(h) : d[h.nodeName] = [d[h.nodeName], this.toObj(h)] : d[h.nodeName] = this.toObj(h)
                    } else a.attributes.length ? d["#text"] = this.escape(this.innerXml(a)) : d = this.escape(this.innerXml(a));
                else if (b) a.attributes.length ? d["#text"] = this.escape(this.innerXml(a)) :
                    (d = this.escape(this.innerXml(a)), "__EMPTY_ARRAY_" === d ? d = "[]" : "__EMPTY_STRING_" === d && (d = ""));
                else if (f)
                    if (1 < f) d = this.escape(this.innerXml(a));
                    else
                        for (h = a.firstChild; h; h = h.nextSibling)
                            if (e.test(a.firstChild.nodeValue)) {
                                d = a.firstChild.nodeValue;
                                break
                            } else d["#cdata"] = this.escape(h.nodeValue)
            }!a.attributes.length && !a.firstChild && (d = null)
        } else 9 === a.nodeType ? d = this.toObj(a.documentElement) : alert("unhandled node type: " + a.nodeType);
        return d
    },
    toJson: function(a, d, e, b) {
        void 0 === b && (b = !0);
        var f = d ? '"' + d + '"' :
            "",
            c = "\t",
            h = "\n";
        b || (h = c = "");
        if ("[]" === a) f += d ? ":[]" : "[]";
        else if (a instanceof Array) {
            var g, i, j = [];
            i = 0;
            for (g = a.length; i < g; i += 1) j[i] = this.toJson(a[i], "", e + c, b);
            f += (d ? ":[" : "[") + (1 < j.length ? h + e + c + j.join("," + h + e + c) + h + e : j.join("")) + "]"
        } else if (null === a) f += (d && ":") + "null";
        else if ("object" === typeof a) {
            g = [];
            for (i in a) a.hasOwnProperty(i) && (g[g.length] = this.toJson(a[i], i, e + c, b));
            f += (d ? ":{" : "{") + (1 < g.length ? h + e + c + g.join("," + h + e + c) + h + e : g.join("")) + "}"
        } else f = "string" === typeof a ? f + ((d && ":") + '"' + a.replace(/\\/g,
            "\\\\").replace(/\"/g, '\\"') + '"') : f + ((d && ":") + a.toString());
        return f
    },
    innerXml: function(a) {
        var d = "";
        if ("innerHTML" in a) d = a.innerHTML;
        else
            for (var e = function(a) {
                var d = "",
                    c;
                if (1 === a.nodeType) {
                    d += "<" + a.nodeName;
                    for (c = 0; c < a.attributes.length; c += 1) d += " " + a.attributes[c].nodeName + '="' + (a.attributes[c].nodeValue || "").toString() + '"';
                    if (a.firstChild) {
                        d += ">";
                        for (c = a.firstChild; c; c = c.nextSibling) d += e(c);
                        d += "</" + a.nodeName + ">"
                    } else d += "/>"
                } else 3 === a.nodeType ? d += a.nodeValue : 4 === a.nodeType && (d += "<![CDATA[" + a.nodeValue +
                    "]]\>");
                return d
            }, a = a.firstChild; a; a = a.nextSibling) d += e(a);
        return d
    },
    escape: function(a) {
        return a.replace(/[\\]/g, "\\\\").replace(/[\"]/g, '\\"').replace(/[\n]/g, "\\n").replace(/[\r]/g, "\\r")
    },
    removeWhite: function(a) {
        a.normalize();
        var d;
        for (d = a.firstChild; d;)
            if (3 === d.nodeType)
                if (d.nodeValue.match(/[^ \f\n\r\t\v]/)) d = d.nextSibling;
                else {
                    var e = d.nextSibling;
                    a.removeChild(d);
                    d = e
                } else 1 === d.nodeType && this.removeWhite(d), d = d.nextSibling;
        return a
    }
};
(function(a) {
    a.fmatter = {};
    a.extend(a.fmatter, {
        isBoolean: function(a) {
            return "boolean" === typeof a
        },
        isObject: function(d) {
            return d && ("object" === typeof d || a.isFunction(d)) || !1
        },
        isString: function(a) {
            return "string" === typeof a
        },
        isNumber: function(a) {
            return "number" === typeof a && isFinite(a)
        },
        isValue: function(a) {
            return this.isObject(a) || this.isString(a) || this.isNumber(a) || this.isBoolean(a)
        },
        isEmpty: function(d) {
            if (!this.isString(d) && this.isValue(d)) return !1;
            if (!this.isValue(d)) return !0;
            d = a.trim(d).replace(/\&nbsp\;/ig,
                "").replace(/\&#160\;/ig, "");
            return "" === d
        }
    });
    a.fn.fmatter = function(d, e, b, f, c) {
        var h = e,
            b = a.extend({}, a.jgrid.formatter, b);
        try {
            h = a.fn.fmatter[d].call(this, e, b, f, c)
        } catch (g) {}
        return h
    };
    a.fmatter.util = {
        NumberFormat: function(d, e) {
            a.fmatter.isNumber(d) || (d *= 1);
            if (a.fmatter.isNumber(d)) {
                var b = 0 > d,
                    f = "" + d,
                    c = e.decimalSeparator || ".",
                    h;
                if (a.fmatter.isNumber(e.decimalPlaces)) {
                    var g = e.decimalPlaces,
                        f = Math.pow(10, g),
                        f = "" + Math.round(d * f) / f;
                    h = f.lastIndexOf(".");
                    if (0 < g) {
                        0 > h ? (f += c, h = f.length - 1) : "." !== c && (f = f.replace(".",
                            c));
                        for (; f.length - 1 - h < g;) f += "0"
                    }
                }
                if (e.thousandsSeparator) {
                    g = e.thousandsSeparator;
                    h = f.lastIndexOf(c);
                    h = -1 < h ? h : f.length;
                    var c = f.substring(h),
                        i = -1,
                        j;
                    for (j = h; 0 < j; j--) {
                        i++;
                        if (0 === i % 3 && j !== h && (!b || 1 < j)) c = g + c;
                        c = f.charAt(j - 1) + c
                    }
                    f = c
                }
                f = e.prefix ? e.prefix + f : f;
                return f = e.suffix ? f + e.suffix : f
            }
            return d
        }
    };
    a.fn.fmatter.defaultFormat = function(d, e) {
        return a.fmatter.isValue(d) && "" !== d ? d : e.defaultValue || "&#160;"
    };
    a.fn.fmatter.email = function(d, e) {
        return !a.fmatter.isEmpty(d) ? '<a href="mailto:' + d + '">' + d + "</a>" : a.fn.fmatter.defaultFormat(d,
            e)
    };
    a.fn.fmatter.checkbox = function(d, e) {
        var b = a.extend({}, e.checkbox),
            f;
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        f = !0 === b.disabled ? 'disabled="disabled"' : "";
        if (a.fmatter.isEmpty(d) || void 0 === d) d = a.fn.fmatter.defaultFormat(d, b);
        d = ("" + d + "").toLowerCase();
        return '<input type="checkbox" ' + (0 > d.search(/(false|f|0|no|n|off|undefined)/i) ? " checked='checked' " : "") + ' value="' + d + '" offval="no" ' + f + "/>"
    };
    a.fn.fmatter.link = function(d, e) {
        var b = {
                target: e.target
            },
            f = "";
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        b.target && (f = "target=" + b.target);
        return !a.fmatter.isEmpty(d) ? "<a " + f + ' href="' + d + '">' + d + "</a>" : a.fn.fmatter.defaultFormat(d, e)
    };
    a.fn.fmatter.showlink = function(d, e) {
        var b = {
                baseLinkUrl: e.baseLinkUrl,
                showAction: e.showAction,
                addParam: e.addParam || "",
                target: e.target,
                idName: e.idName
            },
            f = "";
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        b.target && (f =
            "target=" + b.target);
        b = b.baseLinkUrl + b.showAction + "?" + b.idName + "=" + e.rowId + b.addParam;
        return a.fmatter.isString(d) || a.fmatter.isNumber(d) ? "<a " + f + ' href="' + b + '">' + d + "</a>" : a.fn.fmatter.defaultFormat(d, e)
    };
    a.fn.fmatter.integer = function(d, e) {
        var b = a.extend({}, e.integer);
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        return a.fmatter.isEmpty(d) ? b.defaultValue : a.fmatter.util.NumberFormat(d, b)
    };
    a.fn.fmatter.number = function(d, e) {
        var b = a.extend({}, e.number);
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        return a.fmatter.isEmpty(d) ? b.defaultValue : a.fmatter.util.NumberFormat(d, b)
    };
    a.fn.fmatter.currency = function(d, e) {
        var b = a.extend({}, e.currency);
        void 0 !== e.colModel && void 0 !== e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        return a.fmatter.isEmpty(d) ? b.defaultValue : a.fmatter.util.NumberFormat(d, b)
    };
    a.fn.fmatter.date = function(d, e, b, f) {
        b = a.extend({}, e.date);
        void 0 !== e.colModel && void 0 !==
            e.colModel.formatoptions && (b = a.extend({}, b, e.colModel.formatoptions));
        return !b.reformatAfterEdit && "edit" === f ? a.fn.fmatter.defaultFormat(d, e) : !a.fmatter.isEmpty(d) ? a.jgrid.parseDate(b.srcformat, d, b.newformat, b) : a.fn.fmatter.defaultFormat(d, e)
    };
    a.fn.fmatter.select = function(d, e) {
        var d = "" + d,
            b = !1,
            f = [],
            c, h;
        void 0 !== e.colModel.formatoptions ? (b = e.colModel.formatoptions.value, c = void 0 === e.colModel.formatoptions.separator ? ":" : e.colModel.formatoptions.separator, h = void 0 === e.colModel.formatoptions.delimiter ?
            ";" : e.colModel.formatoptions.delimiter) : void 0 !== e.colModel.editoptions && (b = e.colModel.editoptions.value, c = void 0 === e.colModel.editoptions.separator ? ":" : e.colModel.editoptions.separator, h = void 0 === e.colModel.editoptions.delimiter ? ";" : e.colModel.editoptions.delimiter);
        if (b) {
            var g = !0 === (null != e.colModel.editoptions && !0 === e.colModel.editoptions.multiple) ? !0 : !1,
                i = [];
            g && (i = d.split(","), i = a.map(i, function(b) {
                return a.trim(b)
            }));
            if (a.fmatter.isString(b)) {
                var j = b.split(h),
                    k = 0,
                    m;
                for (m = 0; m < j.length; m++)
                    if (h =
                        j[m].split(c), 2 < h.length && (h[1] = a.map(h, function(a, b) {
                            if (b > 0) return a
                        }).join(c)), g) - 1 < a.inArray(h[0], i) && (f[k] = h[1], k++);
                    else if (a.trim(h[0]) === a.trim(d)) {
                    f[0] = h[1];
                    break
                }
            } else a.fmatter.isObject(b) && (g ? f = a.map(i, function(a) {
                return b[a]
            }) : f[0] = b[d] || "")
        }
        d = f.join(", ");
        return "" === d ? a.fn.fmatter.defaultFormat(d, e) : d
    };
    a.fn.fmatter.rowactions = function(d) {
        var e = a(this).closest("tr.jqgrow"),
            b = e.attr("id"),
            f = a(this).closest("table.ui-jqgrid-btable").attr("id").replace(/_frozen([^_]*)$/, "$1"),
            f = a("#" + f),
            c = f[0],
            h = c.p,
            g = h.colModel[a.jgrid.getCellIndex(this)],
            i = g.frozen ? a("tr#" + b + " td:eq(" + a.jgrid.getCellIndex(this) + ") > div", f) : a(this).parent(),
            j = {
                extraparam: {}
            },
            k = function(b) {
                a.isFunction(j.afterRestore) && j.afterRestore.call(c, b);
                i.find("div.ui-inline-edit,div.ui-inline-del").show();
                i.find("div.ui-inline-save,div.ui-inline-cancel").hide()
            };
        void 0 !== g.formatoptions && (j = a.extend(j, g.formatoptions));
        void 0 !== h.editOptions && (j.editOptions = h.editOptions);
        void 0 !== h.delOptions && (j.delOptions = h.delOptions);
        e.hasClass("jqgrid-new-row") && (j.extraparam[h.prmNames.oper] = h.prmNames.addoper);
        e = {
            keys: j.keys,
            oneditfunc: j.onEdit,
            successfunc: j.onSuccess,
            url: j.url,
            extraparam: j.extraparam,
            aftersavefunc: function(b, d) {
                a.isFunction(j.afterSave) && j.afterSave.call(c, b, d);
                i.find("div.ui-inline-edit,div.ui-inline-del").show();
                i.find("div.ui-inline-save,div.ui-inline-cancel").hide()
            },
            errorfunc: j.onError,
            afterrestorefunc: k,
            restoreAfterError: j.restoreAfterError,
            mtype: j.mtype
        };
        switch (d) {
            case "edit":
                f.jqGrid("editRow", b, e);
                i.find("div.ui-inline-edit,div.ui-inline-del").hide();
                i.find("div.ui-inline-save,div.ui-inline-cancel").show();
                f.triggerHandler("jqGridAfterGridComplete");
                break;
            case "save":
                f.jqGrid("saveRow", b, e) && (i.find("div.ui-inline-edit,div.ui-inline-del").show(), i.find("div.ui-inline-save,div.ui-inline-cancel").hide(), f.triggerHandler("jqGridAfterGridComplete"));
                break;
            case "cancel":
                f.jqGrid("restoreRow", b, k);
                i.find("div.ui-inline-edit,div.ui-inline-del").show();
                i.find("div.ui-inline-save,div.ui-inline-cancel").hide();
                f.triggerHandler("jqGridAfterGridComplete");
                break;
            case "del":
                f.jqGrid("delGridRow", b, j.delOptions);
                break;
            case "formedit":
                f.jqGrid("setSelection", b), f.jqGrid("editGridRow", b, j.editOptions)
        }
    };
    a.fn.fmatter.actions = function(d, e) {
        var b = {
                keys: !1,
                editbutton: !0,
                delbutton: !0,
                editformbutton: !1
            },
            f = e.rowId,
            c = "";
        void 0 !== e.colModel.formatoptions && (b = a.extend(b, e.colModel.formatoptions));
        if (void 0 === f || a.fmatter.isEmpty(f)) return "";
        b.editformbutton ? c += "<div title='" + a.jgrid.nav.edittitle + "' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit' " +
            ("id='jEditButton_" + f + "' onclick=jQuery.fn.fmatter.rowactions.call(this,'formedit'); onmouseover=jQuery(this).addClass('ui-state-hover'); onmouseout=jQuery(this).removeClass('ui-state-hover'); ") + "><span class='ui-icon ui-icon-pencil'></span></div>" : b.editbutton && (c += "<div title='" + a.jgrid.nav.edittitle + "' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit' " + ("id='jEditButton_" + f + "' onclick=jQuery.fn.fmatter.rowactions.call(this,'edit'); onmouseover=jQuery(this).addClass('ui-state-hover'); onmouseout=jQuery(this).removeClass('ui-state-hover') ") +
                "><span class='ui-icon ui-icon-pencil'></span></div>");
        b.delbutton && (c += "<div title='" + a.jgrid.nav.deltitle + "' style='float:left;margin-left:5px;' class='ui-pg-div ui-inline-del' " + ("id='jDeleteButton_" + f + "' onclick=jQuery.fn.fmatter.rowactions.call(this,'del'); onmouseover=jQuery(this).addClass('ui-state-hover'); onmouseout=jQuery(this).removeClass('ui-state-hover'); ") + "><span class='ui-icon ui-icon-trash'></span></div>");
        c += "<div title='" + a.jgrid.edit.bSubmit + "' style='float:left;display:none' class='ui-pg-div ui-inline-save' " +
            ("id='jSaveButton_" + f + "' onclick=jQuery.fn.fmatter.rowactions.call(this,'save'); onmouseover=jQuery(this).addClass('ui-state-hover'); onmouseout=jQuery(this).removeClass('ui-state-hover'); ") + "><span class='ui-icon ui-icon-disk'></span></div>";
        c += "<div title='" + a.jgrid.edit.bCancel + "' style='float:left;display:none;margin-left:5px;' class='ui-pg-div ui-inline-cancel' " + ("id='jCancelButton_" + f + "' onclick=jQuery.fn.fmatter.rowactions.call(this,'cancel'); onmouseover=jQuery(this).addClass('ui-state-hover'); onmouseout=jQuery(this).removeClass('ui-state-hover'); ") +
            "><span class='ui-icon ui-icon-cancel'></span></div>";
        return "<div style='margin-left:8px;'>" + c + "</div>"
    };
    a.unformat = function(d, e, b, f) {
        var c, h = e.colModel.formatter,
            g = e.colModel.formatoptions || {},
            i = /([\.\*\_\'\(\)\{\}\+\?\\])/g,
            j = e.colModel.unformat || a.fn.fmatter[h] && a.fn.fmatter[h].unformat;
        if (void 0 !== j && a.isFunction(j)) c = j.call(this, a(d).text(), e, d);
        else if (void 0 !== h && a.fmatter.isString(h)) switch (c = a.jgrid.formatter || {}, h) {
            case "integer":
                g = a.extend({}, c.integer, g);
                e = g.thousandsSeparator.replace(i,
                    "\\$1");
                e = RegExp(e, "g");
                c = a(d).text().replace(e, "");
                break;
            case "number":
                g = a.extend({}, c.number, g);
                e = g.thousandsSeparator.replace(i, "\\$1");
                e = RegExp(e, "g");
                c = a(d).text().replace(e, "").replace(g.decimalSeparator, ".");
                break;
            case "currency":
                g = a.extend({}, c.currency, g);
                e = g.thousandsSeparator.replace(i, "\\$1");
                e = RegExp(e, "g");
                c = a(d).text();
                g.prefix && g.prefix.length && (c = c.substr(g.prefix.length));
                g.suffix && g.suffix.length && (c = c.substr(0, c.length - g.suffix.length));
                c = c.replace(e, "").replace(g.decimalSeparator,
                    ".");
                break;
            case "checkbox":
                g = e.colModel.editoptions ? e.colModel.editoptions.value.split(":") : ["Yes", "No"];
                c = a("input", d).is(":checked") ? g[0] : g[1];
                break;
            case "select":
                c = a.unformat.select(d, e, b, f);
                break;
            case "actions":
                return "";
            default:
                c = a(d).text()
        }
        return void 0 !== c ? c : !0 === f ? a(d).text() : a.jgrid.htmlDecode(a(d).html())
    };
    a.unformat.select = function(d, e, b, f) {
        b = [];
        d = a(d).text();
        if (!0 === f) return d;
        var f = a.extend({}, void 0 !== e.colModel.formatoptions ? e.colModel.formatoptions : e.colModel.editoptions),
            e = void 0 ===
            f.separator ? ":" : f.separator,
            c = void 0 === f.delimiter ? ";" : f.delimiter;
        if (f.value) {
            var h = f.value,
                f = !0 === f.multiple ? !0 : !1,
                g = [];
            f && (g = d.split(","), g = a.map(g, function(b) {
                return a.trim(b)
            }));
            if (a.fmatter.isString(h)) {
                var i = h.split(c),
                    j = 0,
                    k;
                for (k = 0; k < i.length; k++)
                    if (c = i[k].split(e), 2 < c.length && (c[1] = a.map(c, function(a, b) {
                        if (b > 0) return a
                    }).join(e)), f) - 1 < a.inArray(c[1], g) && (b[j] = c[0], j++);
                    else if (a.trim(c[1]) === a.trim(d)) {
                    b[0] = c[0];
                    break
                }
            } else if (a.fmatter.isObject(h) || a.isArray(h)) f || (g[0] = d), b = a.map(g, function(b) {
                var c;
                a.each(h, function(a, d) {
                    if (d === b) {
                        c = a;
                        return false
                    }
                });
                if (c !== void 0) return c
            });
            return b.join(", ")
        }
        return d || ""
    };
    a.unformat.date = function(d, e) {
        var b = a.jgrid.formatter.date || {};
        void 0 !== e.formatoptions && (b = a.extend({}, b, e.formatoptions));
        return !a.fmatter.isEmpty(d) ? a.jgrid.parseDate(b.newformat, d, b.srcformat, b) : a.fn.fmatter.defaultFormat(d, e)
    }
})(jQuery);
(function(a) {
    a.extend(a.jgrid, {
        showModal: function(a) {
            a.w.show()
        },
        closeModal: function(a) {
            a.w.hide().attr("aria-hidden", "true");
            a.o && a.o.remove()
        },
        hideModal: function(d, e) {
            e = a.extend({
                jqm: !0,
                gb: ""
            }, e || {});
            if (e.onClose) {
                var b = e.gb && "string" === typeof e.gb && "#gbox_" === e.gb.substr(0, 6) ? e.onClose.call(a("#" + e.gb.substr(6))[0], d) : e.onClose(d);
                if ("boolean" === typeof b && !b) return
            }
            if (a.fn.jqm && !0 === e.jqm) a(d).attr("aria-hidden", "true").jqmHide();
            else {
                if ("" !== e.gb) try {
                    a(".jqgrid-overlay:first", e.gb).hide()
                } catch (f) {}
                a(d).hide().attr("aria-hidden",
                    "true")
            }
        },
        findPos: function(a) {
            var e = 0,
                b = 0;
            if (a.offsetParent) {
                do e += a.offsetLeft, b += a.offsetTop; while (a = a.offsetParent)
            }
            return [e, b]
        },
        createModal: function(d, e, b, f, c, h, g) {
            var b = a.extend(!0, {}, a.jgrid.jqModal || {}, b),
                i = document.createElement("div"),
                j, k = this,
                g = a.extend({}, g || {});
            j = "rtl" === a(b.gbox).attr("dir") ? !0 : !1;
            i.className = "ui-widget ui-widget-content ui-corner-all ui-jqdialog";
            i.id = d.themodal;
            var m = document.createElement("div");
            m.className = "ui-jqdialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix";
            m.id = d.modalhead;
            a(m).append("<span class='ui-jqdialog-title'>" + b.caption + "</span>");
            var o = a("<a class='ui-jqdialog-titlebar-close ui-corner-all'></a>").hover(function() {
                o.addClass("ui-state-hover")
            }, function() {
                o.removeClass("ui-state-hover")
            }).append("<span class='ui-icon ui-icon-closethick'></span>");
            a(m).append(o);
            j ? (i.dir = "rtl", a(".ui-jqdialog-title", m).css("float", "right"), a(".ui-jqdialog-titlebar-close", m).css("left", "0.3em")) : (i.dir = "ltr", a(".ui-jqdialog-title", m).css("float", "left"), a(".ui-jqdialog-titlebar-close",
                m).css("right", "0.3em"));
            var n = document.createElement("div");
            a(n).addClass("ui-jqdialog-content ui-widget-content").attr("id", d.modalcontent);
            a(n).append(e);
            i.appendChild(n);
            a(i).prepend(m);
            !0 === h ? a("body").append(i) : "string" === typeof h ? a(h).append(i) : a(i).insertBefore(f);
            a(i).css(g);
            void 0 === b.jqModal && (b.jqModal = !0);
            e = {};
            if (a.fn.jqm && !0 === b.jqModal) 0 === b.left && (0 === b.top && b.overlay) && (g = [], g = a.jgrid.findPos(c), b.left = g[0] + 4, b.top = g[1] + 4), e.top = b.top + "px", e.left = b.left;
            else if (0 !== b.left || 0 !== b.top) e.left =
                b.left, e.top = b.top + "px";
            a("a.ui-jqdialog-titlebar-close", m).click(function() {
                var c = a("#" + a.jgrid.jqID(d.themodal)).data("onClose") || b.onClose,
                    e = a("#" + a.jgrid.jqID(d.themodal)).data("gbox") || b.gbox;
                k.hideModal("#" + a.jgrid.jqID(d.themodal), {
                    gb: e,
                    jqm: b.jqModal,
                    onClose: c
                });
                return false
            });
            if (0 === b.width || !b.width) b.width = 300;
            if (0 === b.height || !b.height) b.height = 200;
            b.zIndex || (f = a(f).parents("*[role=dialog]").filter(":first").css("z-index"), b.zIndex = f ? parseInt(f, 10) + 2 : 950);
            f = 0;
            j && (e.left && !h) && (f = a(b.gbox).width() -
                (!isNaN(b.width) ? parseInt(b.width, 10) : 0) - 8, e.left = parseInt(e.left, 10) + parseInt(f, 10));
            e.left && (e.left += "px");
            a(i).css(a.extend({
                width: isNaN(b.width) ? "auto" : b.width + "px",
                height: isNaN(b.height) ? "auto" : b.height + "px",
                zIndex: b.zIndex,
                overflow: "hidden"
            }, e)).attr({
                tabIndex: "-1",
                role: "dialog",
                "aria-labelledby": d.modalhead,
                "aria-hidden": "true"
            });
            void 0 === b.drag && (b.drag = !0);
            void 0 === b.resize && (b.resize = !0);
            if (b.drag)
                if (a(m).css("cursor", "move"), a.fn.jqDrag) a(i).jqDrag(m);
                else try {
                    a(i).draggable({
                        handle: a("#" +
                            a.jgrid.jqID(m.id))
                    })
                } catch (l) {}
                if (b.resize)
                    if (a.fn.jqResize) a(i).append("<div class='jqResize ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se'></div>"), a("#" + a.jgrid.jqID(d.themodal)).jqResize(".jqResize", d.scrollelm ? "#" + a.jgrid.jqID(d.scrollelm) : !1);
                    else try {
                        a(i).resizable({
                            handles: "se, sw",
                            alsoResize: d.scrollelm ? "#" + a.jgrid.jqID(d.scrollelm) : !1
                        })
                    } catch (p) {}!0 === b.closeOnEscape && a(i).keydown(function(c) {
                        if (c.which == 27) {
                            c = a("#" + a.jgrid.jqID(d.themodal)).data("onClose") ||
                                b.onClose;
                            k.hideModal("#" + a.jgrid.jqID(d.themodal), {
                                gb: b.gbox,
                                jqm: b.jqModal,
                                onClose: c
                            })
                        }
                    })
        },
        viewModal: function(d, e) {
            e = a.extend({
                toTop: !0,
                overlay: 10,
                modal: !1,
                overlayClass: "ui-widget-overlay",
                onShow: a.jgrid.showModal,
                onHide: a.jgrid.closeModal,
                gbox: "",
                jqm: !0,
                jqM: !0
            }, e || {});
            if (a.fn.jqm && !0 === e.jqm) e.jqM ? a(d).attr("aria-hidden", "false").jqm(e).jqmShow() : a(d).attr("aria-hidden", "false").jqmShow();
            else {
                "" !== e.gbox && (a(".jqgrid-overlay:first", e.gbox).show(), a(d).data("gbox", e.gbox));
                a(d).show().attr("aria-hidden",
                    "false");
                try {
                    a(":input:visible", d)[0].focus()
                } catch (b) {}
            }
        },
        info_dialog: function(d, e, b, f) {
            var c = {
                width: 290,
                height: "auto",
                dataheight: "auto",
                drag: !0,
                resize: !1,
                left: 250,
                top: 170,
                zIndex: 1E3,
                jqModal: !0,
                modal: !1,
                closeOnEscape: !0,
                align: "center",
                buttonalign: "center",
                buttons: []
            };
            a.extend(!0, c, a.jgrid.jqModal || {}, {
                caption: "<b>" + d + "</b>"
            }, f || {});
            var h = c.jqModal,
                g = this;
            a.fn.jqm && !h && (h = !1);
            d = "";
            if (0 < c.buttons.length)
                for (f = 0; f < c.buttons.length; f++) void 0 === c.buttons[f].id && (c.buttons[f].id = "info_button_" + f), d +=
                    "<a id='" + c.buttons[f].id + "' class='fm-button ui-state-default ui-corner-all'>" + c.buttons[f].text + "</a>";
            f = isNaN(c.dataheight) ? c.dataheight : c.dataheight + "px";
            e = "<div id='info_id'>" + ("<div id='infocnt' style='margin:0px;padding-bottom:1em;width:100%;overflow:auto;position:relative;height:" + f + ";" + ("text-align:" + c.align + ";") + "'>" + e + "</div>");
            e += b ? "<div class='ui-widget-content ui-helper-clearfix' style='text-align:" + c.buttonalign + ";padding-bottom:0.8em;padding-top:0.5em;background-image: none;border-width: 1px 0 0 0;'><a id='closedialog' class='fm-button ui-state-default ui-corner-all'>" +
                b + "</a>" + d + "</div>" : "" !== d ? "<div class='ui-widget-content ui-helper-clearfix' style='text-align:" + c.buttonalign + ";padding-bottom:0.8em;padding-top:0.5em;background-image: none;border-width: 1px 0 0 0;'>" + d + "</div>" : "";
            e += "</div>";
            try {
                "false" === a("#info_dialog").attr("aria-hidden") && a.jgrid.hideModal("#info_dialog", {
                    jqm: h
                }), a("#info_dialog").remove()
            } catch (i) {}
            a.jgrid.createModal({
                themodal: "info_dialog",
                modalhead: "info_head",
                modalcontent: "info_content",
                scrollelm: "infocnt"
            }, e, c, "", "", !0);
            d && a.each(c.buttons,
                function(b) {
                    a("#" + a.jgrid.jqID(this.id), "#info_id").bind("click", function() {
                        c.buttons[b].onClick.call(a("#info_dialog"));
                        return !1
                    })
                });
            a("#closedialog", "#info_id").click(function() {
                g.hideModal("#info_dialog", {
                    jqm: h,
                    onClose: a("#info_dialog").data("onClose") || c.onClose,
                    gb: a("#info_dialog").data("gbox") || c.gbox
                });
                return !1
            });
            a(".fm-button", "#info_dialog").hover(function() {
                a(this).addClass("ui-state-hover")
            }, function() {
                a(this).removeClass("ui-state-hover")
            });
            a.isFunction(c.beforeOpen) && c.beforeOpen();
            a.jgrid.viewModal("#info_dialog", {
                onHide: function(a) {
                    a.w.hide().remove();
                    a.o && a.o.remove()
                },
                modal: c.modal,
                jqm: h
            });
            a.isFunction(c.afterOpen) && c.afterOpen();
            try {
                a("#info_dialog").focus()
            } catch (j) {}
        },
        bindEv: function(d, e) {
            a.isFunction(e.dataInit) && e.dataInit.call(this, d, e);
            e.dataEvents && a.each(e.dataEvents, function() {
                void 0 !== this.data ? a(d).bind(this.type, this.data, this.fn) : a(d).bind(this.type, this.fn)
            })
        },
        createEl: function(d, e, b, f, c) {
            function h(b, c, d) {
                var e = "dataInit dataEvents dataUrl buildSelect sopt searchhidden defaultValue attr custom_element custom_value".split(" ");
                void 0 !== d && a.isArray(d) && a.merge(e, d);
                a.each(c, function(c, d) {
                    -1 === a.inArray(c, e) && a(b).attr(c, d)
                });
                c.hasOwnProperty("id") || a(b).attr("id", a.jgrid.randId())
            }
            var g = "",
                i = this;
            switch (d) {
                case "textarea":
                    g = document.createElement("textarea");
                    f ? e.cols || a(g).css({
                        width: "98%"
                    }) : e.cols || (e.cols = 20);
                    e.rows || (e.rows = 2);
                    if ("&nbsp;" === b || "&#160;" === b || 1 === b.length && 160 === b.charCodeAt(0)) b = "";
                    g.value = b;
                    h(g, e);
                    a(g).attr({
                        role: "textbox",
                        multiline: "true"
                    });
                    break;
                case "checkbox":
                    g = document.createElement("input");
                    g.type =
                        "checkbox";
                    e.value ? (d = e.value.split(":"), b === d[0] && (g.checked = !0, g.defaultChecked = !0), g.value = d[0], a(g).attr("offval", d[1])) : (d = (b + "").toLowerCase(), 0 > d.search(/(false|f|0|no|n|off|undefined)/i) && "" !== d ? (g.checked = !0, g.defaultChecked = !0, g.value = b) : g.value = "on", a(g).attr("offval", "off"));
                    h(g, e, ["value"]);
                    a(g).attr("role", "checkbox");
                    break;
                case "select":
                    g = document.createElement("select");
                    g.setAttribute("role", "select");
                    f = [];
                    !0 === e.multiple ? (d = !0, g.multiple = "multiple", a(g).attr("aria-multiselectable",
                        "true")) : d = !1;
                    if (void 0 !== e.dataUrl) {
                        var d = null,
                            j = e.postData || c.postData;
                        try {
                            d = e.rowId
                        } catch (k) {}
                        i.p && i.p.idPrefix && (d = a.jgrid.stripPref(i.p.idPrefix, d));
                        a.ajax(a.extend({
                            url: a.isFunction(e.dataUrl) ? e.dataUrl.call(i, d, b, "" + e.name) : e.dataUrl,
                            type: "GET",
                            dataType: "html",
                            data: a.isFunction(j) ? j.call(i, d, b, "" + e.name) : j,
                            context: {
                                elem: g,
                                options: e,
                                vl: b
                            },
                            success: function(b) {
                                var c = [],
                                    d = this.elem,
                                    e = this.vl,
                                    f = a.extend({}, this.options),
                                    g = f.multiple === true,
                                    b = a.isFunction(f.buildSelect) ? f.buildSelect.call(i, b) : b;
                                typeof b === "string" && (b = a(a.trim(b)).html());
                                if (b) {
                                    a(d).append(b);
                                    h(d, f, j ? ["postData"] : void 0);
                                    if (f.size === void 0) f.size = g ? 3 : 1;
                                    if (g) {
                                        c = e.split(",");
                                        c = a.map(c, function(b) {
                                            return a.trim(b)
                                        })
                                    } else c[0] = a.trim(e);
                                    setTimeout(function() {
                                        a("option", d).each(function(b) {
                                            if (b === 0 && d.multiple) this.selected = false;
                                            a(this).attr("role", "option");
                                            if (a.inArray(a.trim(a(this).text()), c) > -1 || a.inArray(a.trim(a(this).val()), c) > -1) this.selected = "selected"
                                        })
                                    }, 0)
                                }
                            }
                        }, c || {}))
                    } else if (e.value) {
                        var m;
                        void 0 === e.size && (e.size =
                            d ? 3 : 1);
                        d && (f = b.split(","), f = a.map(f, function(b) {
                            return a.trim(b)
                        }));
                        "function" === typeof e.value && (e.value = e.value());
                        var o, n, l = void 0 === e.separator ? ":" : e.separator,
                            c = void 0 === e.delimiter ? ";" : e.delimiter;
                        if ("string" === typeof e.value) {
                            o = e.value.split(c);
                            for (m = 0; m < o.length; m++) {
                                n = o[m].split(l);
                                2 < n.length && (n[1] = a.map(n, function(a, b) {
                                    if (b > 0) return a
                                }).join(l));
                                c = document.createElement("option");
                                c.setAttribute("role", "option");
                                c.value = n[0];
                                c.innerHTML = n[1];
                                g.appendChild(c);
                                if (!d && (a.trim(n[0]) === a.trim(b) ||
                                    a.trim(n[1]) === a.trim(b))) c.selected = "selected";
                                if (d && (-1 < a.inArray(a.trim(n[1]), f) || -1 < a.inArray(a.trim(n[0]), f))) c.selected = "selected"
                            }
                        } else if ("object" === typeof e.value)
                            for (m in l = e.value, l)
                                if (l.hasOwnProperty(m)) {
                                    c = document.createElement("option");
                                    c.setAttribute("role", "option");
                                    c.value = m;
                                    c.innerHTML = l[m];
                                    g.appendChild(c);
                                    if (!d && (a.trim(m) === a.trim(b) || a.trim(l[m]) === a.trim(b))) c.selected = "selected";
                                    if (d && (-1 < a.inArray(a.trim(l[m]), f) || -1 < a.inArray(a.trim(m), f))) c.selected = "selected"
                                }
                        h(g, e, ["value"])
                    }
                    break;
                case "text":
                case "password":
                case "button":
                    m = "button" === d ? "button" : "textbox";
                    g = document.createElement("input");
                    g.type = d;
                    g.value = b;
                    h(g, e);
                    "button" !== d && (f ? e.size || a(g).css({
                        width: "98%"
                    }) : e.size || (e.size = 20));
                    a(g).attr("role", m);
                    break;
                case "image":
                case "file":
                    g = document.createElement("input");
                    g.type = d;
                    h(g, e);
                    break;
                case "custom":
                    g = document.createElement("span");
                    try {
                        if (a.isFunction(e.custom_element))
                            if (l = e.custom_element.call(i, b, e)) l = a(l).addClass("customelement").attr({
                                id: e.id,
                                name: e.name
                            }), a(g).empty().append(l);
                            else throw "e2";
                        else throw "e1";
                    } catch (p) {
                        "e1" === p && a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_element' " + a.jgrid.edit.msg.nodefined, a.jgrid.edit.bClose), "e2" === p ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_element' " + a.jgrid.edit.msg.novalue, a.jgrid.edit.bClose) : a.jgrid.info_dialog(a.jgrid.errors.errcap, "string" === typeof p ? p : p.message, a.jgrid.edit.bClose)
                    }
            }
            return g
        },
        checkDate: function(a, e) {
            var b = {},
                f, a = a.toLowerCase();
            f = -1 !== a.indexOf("/") ? "/" : -1 !== a.indexOf("-") ? "-" :
                -1 !== a.indexOf(".") ? "." : "/";
            a = a.split(f);
            e = e.split(f);
            if (3 !== e.length) return !1;
            f = -1;
            var c, h = -1,
                g = -1,
                i;
            for (i = 0; i < a.length; i++) c = isNaN(e[i]) ? 0 : parseInt(e[i], 10), b[a[i]] = c, c = a[i], -1 !== c.indexOf("y") && (f = i), -1 !== c.indexOf("m") && (g = i), -1 !== c.indexOf("d") && (h = i);
            c = "y" === a[f] || "yyyy" === a[f] ? 4 : "yy" === a[f] ? 2 : -1;
            i = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var j;
            if (-1 === f) return !1;
            j = b[a[f]].toString();
            2 === c && 1 === j.length && (c = 1);
            if (j.length !== c || 0 === b[a[f]] && "00" !== e[f] || -1 === g) return !1;
            j = b[a[g]].toString();
            if (1 >
                j.length || (1 > b[a[g]] || 12 < b[a[g]]) || -1 === h) return !1;
            j = b[a[h]].toString();
            return 1 > j.length || 1 > b[a[h]] || 31 < b[a[h]] || 2 === b[a[g]] && b[a[h]] > (0 === b[a[f]] % 4 && (0 !== b[a[f]] % 100 || 0 === b[a[f]] % 400) ? 29 : 28) || b[a[h]] > i[b[a[g]]] ? !1 : !0
        },
        isEmpty: function(a) {
            return a.match(/^\s+$/) || "" === a ? !0 : !1
        },
        checkTime: function(d) {
            var e = /^(\d{1,2}):(\d{2})([apAP][Mm])?$/;
            if (!a.jgrid.isEmpty(d))
                if (d = d.match(e)) {
                    if (d[3]) {
                        if (1 > d[1] || 12 < d[1]) return !1
                    } else if (23 < d[1]) return !1;
                    if (59 < d[2]) return !1
                } else return !1;
            return !0
        },
        checkValues: function(d,
            e, b, f) {
            var c, h, g;
            g = this.p.colModel;
            if (void 0 === b)
                if ("string" === typeof e) {
                    b = 0;
                    for (f = g.length; b < f; b++)
                        if (g[b].name === e) {
                            c = g[b].editrules;
                            e = b;
                            null != g[b].formoptions && (h = g[b].formoptions.label);
                            break
                        }
                } else 0 <= e && (c = g[e].editrules);
            else c = b, h = void 0 === f ? "_" : f; if (c) {
                h || (h = null != this.p.colNames ? this.p.colNames[e] : g[e].label);
                if (!0 === c.required && a.jgrid.isEmpty(d)) return [!1, h + ": " + a.jgrid.edit.msg.required, ""];
                b = !1 === c.required ? !1 : !0;
                if (!0 === c.number && !(!1 === b && a.jgrid.isEmpty(d)) && isNaN(d)) return [!1, h + ": " +
                    a.jgrid.edit.msg.number, ""
                ];
                if (void 0 !== c.minValue && !isNaN(c.minValue) && parseFloat(d) < parseFloat(c.minValue)) return [!1, h + ": " + a.jgrid.edit.msg.minValue + " " + c.minValue, ""];
                if (void 0 !== c.maxValue && !isNaN(c.maxValue) && parseFloat(d) > parseFloat(c.maxValue)) return [!1, h + ": " + a.jgrid.edit.msg.maxValue + " " + c.maxValue, ""];
                if (!0 === c.email && !(!1 === b && a.jgrid.isEmpty(d)) && (f = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, !f.test(d))) return [!1, h + ": " + a.jgrid.edit.msg.email, ""];
                if (!0 === c.integer && !(!1 === b && a.jgrid.isEmpty(d)) && (isNaN(d) || 0 !== d % 1 || -1 !== d.indexOf("."))) return [!1, h + ": " + a.jgrid.edit.msg.integer, ""];
                if (!0 === c.date && !(!1 === b && a.jgrid.isEmpty(d)) && (g[e].formatoptions && g[e].formatoptions.newformat ? (g = g[e].formatoptions.newformat, a.jgrid.formatter.date.masks.hasOwnProperty(g) && (g = a.jgrid.formatter.date.masks[g])) : g = g[e].datefmt || "Y-m-d", !a.jgrid.checkDate(g, d))) return [!1, h + ": " + a.jgrid.edit.msg.date + " - " +
                    g, ""
                ];
                if (!0 === c.time && !(!1 === b && a.jgrid.isEmpty(d)) && !a.jgrid.checkTime(d)) return [!1, h + ": " + a.jgrid.edit.msg.date + " - hh:mm (am/pm)", ""];
                if (!0 === c.url && !(!1 === b && a.jgrid.isEmpty(d)) && (f = /^(((https?)|(ftp)):\/\/([\-\w]+\.)+\w{2,3}(\/[%\-\w]+(\.\w{2,})?)*(([\w\-\.\?\\\/+@&#;`~=%!]*)(\.\w{2,})?)*\/?)/i, !f.test(d))) return [!1, h + ": " + a.jgrid.edit.msg.url, ""];
                if (!0 === c.custom && !(!1 === b && a.jgrid.isEmpty(d))) return a.isFunction(c.custom_func) ? (d = c.custom_func.call(this, d, h, e), a.isArray(d) ? d : [!1, a.jgrid.edit.msg.customarray,
                    ""
                ]) : [!1, a.jgrid.edit.msg.customfcheck, ""]
            }
            return [!0, "", ""]
        }
    })
})(jQuery);
(function(a) {
    a.fn.jqFilter = function(d) {
        if ("string" === typeof d) {
            var e = a.fn.jqFilter[d];
            if (!e) throw "jqFilter - No such method: " + d;
            var b = a.makeArray(arguments).slice(1);
            return e.apply(this, b)
        }
        var f = a.extend(!0, {
            filter: null,
            columns: [],
            onChange: null,
            afterRedraw: null,
            checkValues: null,
            error: !1,
            errmsg: "",
            errorcheck: !0,
            showQuery: !0,
            sopt: null,
            ops: [],
            operands: null,
            numopts: "eq ne lt le gt ge nu nn in ni".split(" "),
            stropts: "eq ne bw bn ew en cn nc nu nn in ni".split(" "),
            strarr: ["text", "string", "blob"],
            groupOps: [{
                op: "AND",
                text: "AND"
            }, {
                op: "OR",
                text: "OR"
            }],
            groupButton: !0,
            ruleButtons: !0,
            direction: "ltr"
        }, a.jgrid.filter, d || {});
        return this.each(function() {
            if (!this.filter) {
                this.p = f;
                if (null === this.p.filter || void 0 === this.p.filter) this.p.filter = {
                    groupOp: this.p.groupOps[0].op,
                    rules: [],
                    groups: []
                };
                var b, d = this.p.columns.length,
                    e, i = /msie/i.test(navigator.userAgent) && !window.opera;
                this.p.initFilter = a.extend(!0, {}, this.p.filter);
                if (d) {
                    for (b = 0; b < d; b++)
                        if (e = this.p.columns[b], e.stype ? e.inputtype = e.stype : e.inputtype || (e.inputtype = "text"),
                            e.sorttype ? e.searchtype = e.sorttype : e.searchtype || (e.searchtype = "string"), void 0 === e.hidden && (e.hidden = !1), e.label || (e.label = e.name), e.index && (e.name = e.index), e.hasOwnProperty("searchoptions") || (e.searchoptions = {}), !e.hasOwnProperty("searchrules")) e.searchrules = {};
                    this.p.showQuery && a(this).append("<table class='queryresult ui-widget ui-widget-content' style='display:block;max-width:440px;border:0px none;' dir='" + this.p.direction + "'><tbody><tr><td class='query'></td></tr></tbody></table>");
                    var j = function() {
                            return a("#" +
                                a.jgrid.jqID(f.id))[0] || null
                        },
                        k = function(b, c) {
                            var d = [!0, ""],
                                e = j();
                            if (a.isFunction(c.searchrules)) d = c.searchrules.call(e, b, c);
                            else if (a.jgrid && a.jgrid.checkValues) try {
                                d = a.jgrid.checkValues.call(e, b, -1, c.searchrules, c.label)
                            } catch (g) {}
                            d && (d.length && !1 === d[0]) && (f.error = !d[0], f.errmsg = d[1])
                        };
                    this.onchange = function() {
                        this.p.error = !1;
                        this.p.errmsg = "";
                        return a.isFunction(this.p.onChange) ? this.p.onChange.call(this, this.p) : !1
                    };
                    this.reDraw = function() {
                        a("table.group:first", this).remove();
                        var b = this.createTableForGroup(f.filter,
                            null);
                        a(this).append(b);
                        a.isFunction(this.p.afterRedraw) && this.p.afterRedraw.call(this, this.p)
                    };
                    this.createTableForGroup = function(b, c) {
                        var d = this,
                            e, g = a("<table class='group ui-widget ui-widget-content' style='border:0px none;'><tbody></tbody></table>"),
                            i = "left";
                        "rtl" === this.p.direction && (i = "right", g.attr("dir", "rtl"));
                        null === c && g.append("<tr class='error' style='display:none;'><th colspan='5' class='ui-state-error' align='" + i + "'></th></tr>");
                        var h = a("<tr></tr>");
                        g.append(h);
                        i = a("<th colspan='5' align='" +
                            i + "'></th>");
                        h.append(i);
                        if (!0 === this.p.ruleButtons) {
                            var j = a("<select class='opsel'></select>");
                            i.append(j);
                            var h = "",
                                k;
                            for (e = 0; e < f.groupOps.length; e++) k = b.groupOp === d.p.groupOps[e].op ? " selected='selected'" : "", h += "<option value='" + d.p.groupOps[e].op + "'" + k + ">" + d.p.groupOps[e].text + "</option>";
                            j.append(h).bind("change", function() {
                                b.groupOp = a(j).val();
                                d.onchange()
                            })
                        }
                        h = "<span></span>";
                        this.p.groupButton && (h = a("<input type='button' value='+ {}' title='Add subgroup' class='add-group'/>"), h.bind("click",
                            function() {
                                if (b.groups === void 0) b.groups = [];
                                b.groups.push({
                                    groupOp: f.groupOps[0].op,
                                    rules: [],
                                    groups: []
                                });
                                d.reDraw();
                                d.onchange();
                                return false
                            }));
                        i.append(h);
                        if (!0 === this.p.ruleButtons) {
                            var h = a("<input type='button' value='+' title='Add rule' class='add-rule ui-add'/>"),
                                w;
                            h.bind("click", function() {
                                if (b.rules === void 0) b.rules = [];
                                for (e = 0; e < d.p.columns.length; e++) {
                                    var c = d.p.columns[e].search === void 0 ? true : d.p.columns[e].search,
                                        f = d.p.columns[e].hidden === true;
                                    if (d.p.columns[e].searchoptions.searchhidden ===
                                        true && c || c && !f) {
                                        w = d.p.columns[e];
                                        break
                                    }
                                }
                                c = w.searchoptions.sopt ? w.searchoptions.sopt : d.p.sopt ? d.p.sopt : a.inArray(w.searchtype, d.p.strarr) !== -1 ? d.p.stropts : d.p.numopts;
                                b.rules.push({
                                    field: w.name,
                                    op: c[0],
                                    data: ""
                                });
                                d.reDraw();
                                return false
                            });
                            i.append(h)
                        }
                        null !== c && (h = a("<input type='button' value='-' title='Delete group' class='delete-group'/>"), i.append(h), h.bind("click", function() {
                            for (e = 0; e < c.groups.length; e++)
                                if (c.groups[e] === b) {
                                    c.groups.splice(e, 1);
                                    break
                                }
                            d.reDraw();
                            d.onchange();
                            return false
                        }));
                        if (void 0 !==
                            b.groups)
                            for (e = 0; e < b.groups.length; e++) i = a("<tr></tr>"), g.append(i), h = a("<td class='first'></td>"), i.append(h), h = a("<td colspan='4'></td>"), h.append(this.createTableForGroup(b.groups[e], b)), i.append(h);
                        void 0 === b.groupOp && (b.groupOp = d.p.groupOps[0].op);
                        if (void 0 !== b.rules)
                            for (e = 0; e < b.rules.length; e++) g.append(this.createTableRowForRule(b.rules[e], b));
                        return g
                    };
                    this.createTableRowForRule = function(b, c) {
                        var d = this,
                            e = j(),
                            g = a("<tr></tr>"),
                            h, k, s, t, w = "",
                            v;
                        g.append("<td class='first'></td>");
                        var x = a("<td class='columns'></td>");
                        g.append(x);
                        var H = a("<select></select>"),
                            y, D = [];
                        x.append(H);
                        H.bind("change", function() {
                            b.field = a(H).val();
                            s = a(this).parents("tr:first");
                            for (h = 0; h < d.p.columns.length; h++)
                                if (d.p.columns[h].name === b.field) {
                                    t = d.p.columns[h];
                                    break
                                }
                            if (t) {
                                t.searchoptions.id = a.jgrid.randId();
                                i && "text" === t.inputtype && !t.searchoptions.size && (t.searchoptions.size = 10);
                                var c = a.jgrid.createEl.call(e, t.inputtype, t.searchoptions, "", !0, d.p.ajaxSelectOptions || {}, !0);
                                a(c).addClass("input-elm");
                                k = t.searchoptions.sopt ? t.searchoptions.sopt :
                                    d.p.sopt ? d.p.sopt : -1 !== a.inArray(t.searchtype, d.p.strarr) ? d.p.stropts : d.p.numopts;
                                var f = "",
                                    g = 0;
                                D = [];
                                a.each(d.p.ops, function() {
                                    D.push(this.oper)
                                });
                                for (h = 0; h < k.length; h++) y = a.inArray(k[h], D), -1 !== y && (0 === g && (b.op = d.p.ops[y].oper), f += "<option value='" + d.p.ops[y].oper + "'>" + d.p.ops[y].text + "</option>", g++);
                                a(".selectopts", s).empty().append(f);
                                a(".selectopts", s)[0].selectedIndex = 0;
                                a.jgrid.msie && 9 > a.jgrid.msiever() && (f = parseInt(a("select.selectopts", s)[0].offsetWidth, 10) + 1, a(".selectopts", s).width(f), a(".selectopts",
                                    s).css("width", "auto"));
                                a(".data", s).empty().append(c);
                                a.jgrid.bindEv.call(e, c, t.searchoptions);
                                a(".input-elm", s).bind("change", function(c) {
                                    c = c.target;
                                    b.data = c.nodeName.toUpperCase() === "SPAN" && t.searchoptions && a.isFunction(t.searchoptions.custom_value) ? t.searchoptions.custom_value.call(e, a(c).children(".customelement:first"), "get") : c.value;
                                    d.onchange()
                                });
                                setTimeout(function() {
                                    b.data = a(c).val();
                                    d.onchange()
                                }, 0)
                            }
                        });
                        for (h = x = 0; h < d.p.columns.length; h++) {
                            v = void 0 === d.p.columns[h].search ? !0 : d.p.columns[h].search;
                            var z = !0 === d.p.columns[h].hidden;
                            if (!0 === d.p.columns[h].searchoptions.searchhidden && v || v && !z) v = "", b.field === d.p.columns[h].name && (v = " selected='selected'", x = h), w += "<option value='" + d.p.columns[h].name + "'" + v + ">" + d.p.columns[h].label + "</option>"
                        }
                        H.append(w);
                        w = a("<td class='operators'></td>");
                        g.append(w);
                        t = f.columns[x];
                        t.searchoptions.id = a.jgrid.randId();
                        i && "text" === t.inputtype && !t.searchoptions.size && (t.searchoptions.size = 10);
                        x = a.jgrid.createEl.call(e, t.inputtype, t.searchoptions, b.data, !0, d.p.ajaxSelectOptions || {}, !0);
                        if ("nu" === b.op || "nn" === b.op) a(x).attr("readonly", "true"), a(x).attr("disabled", "true");
                        var u = a("<select class='selectopts'></select>");
                        w.append(u);
                        u.bind("change", function() {
                            b.op = a(u).val();
                            s = a(this).parents("tr:first");
                            var c = a(".input-elm", s)[0];
                            if (b.op === "nu" || b.op === "nn") {
                                b.data = "";
                                if (c.tagName.toUpperCase() !== "SELECT") c.value = "";
                                c.setAttribute("readonly", "true");
                                c.setAttribute("disabled", "true")
                            } else {
                                if (c.tagName.toUpperCase() === "SELECT") b.data = c.value;
                                c.removeAttribute("readonly");
                                c.removeAttribute("disabled")
                            }
                            d.onchange()
                        });
                        k = t.searchoptions.sopt ? t.searchoptions.sopt : d.p.sopt ? d.p.sopt : -1 !== a.inArray(t.searchtype, d.p.strarr) ? d.p.stropts : d.p.numopts;
                        w = "";
                        a.each(d.p.ops, function() {
                            D.push(this.oper)
                        });
                        for (h = 0; h < k.length; h++) y = a.inArray(k[h], D), -1 !== y && (v = b.op === d.p.ops[y].oper ? " selected='selected'" : "", w += "<option value='" + d.p.ops[y].oper + "'" + v + ">" + d.p.ops[y].text + "</option>");
                        u.append(w);
                        w = a("<td class='data'></td>");
                        g.append(w);
                        w.append(x);
                        a.jgrid.bindEv.call(e, x, t.searchoptions);
                        a(x).addClass("input-elm").bind("change",
                            function() {
                                b.data = t.inputtype === "custom" ? t.searchoptions.custom_value.call(e, a(this).children(".customelement:first"), "get") : a(this).val();
                                d.onchange()
                            });
                        w = a("<td></td>");
                        g.append(w);
                        !0 === this.p.ruleButtons && (x = a("<input type='button' value='-' title='Delete rule' class='delete-rule ui-del'/>"), w.append(x), x.bind("click", function() {
                            for (h = 0; h < c.rules.length; h++)
                                if (c.rules[h] === b) {
                                    c.rules.splice(h, 1);
                                    break
                                }
                            d.reDraw();
                            d.onchange();
                            return false
                        }));
                        return g
                    };
                    this.getStringForGroup = function(a) {
                        var b = "(",
                            c;
                        if (void 0 !== a.groups)
                            for (c = 0; c < a.groups.length; c++) {
                                1 < b.length && (b += " " + a.groupOp + " ");
                                try {
                                    b += this.getStringForGroup(a.groups[c])
                                } catch (d) {
                                    alert(d)
                                }
                            }
                        if (void 0 !== a.rules) try {
                            for (c = 0; c < a.rules.length; c++) 1 < b.length && (b += " " + a.groupOp + " "), b += this.getStringForRule(a.rules[c])
                        } catch (e) {
                            alert(e)
                        }
                        b += ")";
                        return "()" === b ? "" : b
                    };
                    this.getStringForRule = function(b) {
                        var c = "",
                            d = "",
                            e, g;
                        for (e = 0; e < this.p.ops.length; e++)
                            if (this.p.ops[e].oper === b.op) {
                                c = this.p.operands.hasOwnProperty(b.op) ? this.p.operands[b.op] : "";
                                d =
                                    this.p.ops[e].oper;
                                break
                            }
                        for (e = 0; e < this.p.columns.length; e++)
                            if (this.p.columns[e].name === b.field) {
                                g = this.p.columns[e];
                                break
                            }
                        if (void 0 == g) return "";
                        e = b.data;
                        if ("bw" === d || "bn" === d) e += "%";
                        if ("ew" === d || "en" === d) e = "%" + e;
                        if ("cn" === d || "nc" === d) e = "%" + e + "%";
                        if ("in" === d || "ni" === d) e = " (" + e + ")";
                        f.errorcheck && k(b.data, g);
                        return -1 !== a.inArray(g.searchtype, ["int", "integer", "float", "number", "currency"]) || "nn" === d || "nu" === d ? b.field + " " + c + " " + e : b.field + " " + c + ' "' + e + '"'
                    };
                    this.resetFilter = function() {
                        this.p.filter = a.extend(!0, {}, this.p.initFilter);
                        this.reDraw();
                        this.onchange()
                    };
                    this.hideError = function() {
                        a("th.ui-state-error", this).html("");
                        a("tr.error", this).hide()
                    };
                    this.showError = function() {
                        a("th.ui-state-error", this).html(this.p.errmsg);
                        a("tr.error", this).show()
                    };
                    this.toUserFriendlyString = function() {
                        return this.getStringForGroup(f.filter)
                    };
                    this.toString = function() {
                        function a(c) {
                            var d = "(",
                                e;
                            if (void 0 !== c.groups)
                                for (e = 0; e < c.groups.length; e++) 1 < d.length && (d = "OR" === c.groupOp ? d + " || " : d + " && "), d += a(c.groups[e]);
                            if (void 0 !==
                                c.rules)
                                for (e = 0; e < c.rules.length; e++) {
                                    1 < d.length && (d = "OR" === c.groupOp ? d + " || " : d + " && ");
                                    var f = c.rules[e];
                                    if (b.p.errorcheck) {
                                        for (var g = void 0, i = void 0, g = 0; g < b.p.columns.length; g++)
                                            if (b.p.columns[g].name === f.field) {
                                                i = b.p.columns[g];
                                                break
                                            }
                                        i && k(f.data, i)
                                    }
                                    d += f.op + "(item." + f.field + ",'" + f.data + "')"
                                }
                            d += ")";
                            return "()" === d ? "" : d
                        }
                        var b = this;
                        return a(this.p.filter)
                    };
                    this.reDraw();
                    if (this.p.showQuery) this.onchange();
                    this.filter = !0
                }
            }
        })
    };
    a.extend(a.fn.jqFilter, {
        toSQLString: function() {
            var a = "";
            this.each(function() {
                a =
                    this.toUserFriendlyString()
            });
            return a
        },
        filterData: function() {
            var a;
            this.each(function() {
                a = this.p.filter
            });
            return a
        },
        getParameter: function(a) {
            return void 0 !== a && this.p.hasOwnProperty(a) ? this.p[a] : this.p
        },
        resetFilter: function() {
            return this.each(function() {
                this.resetFilter()
            })
        },
        addFilter: function(d) {
            "string" === typeof d && (d = a.jgrid.parse(d));
            this.each(function() {
                this.p.filter = d;
                this.reDraw();
                this.onchange()
            })
        }
    })
})(jQuery);
(function(a) {
    var d = {};
    a.jgrid.extend({
        searchGrid: function(d) {
            d = a.extend(!0, {
                recreateFilter: !1,
                drag: !0,
                sField: "searchField",
                sValue: "searchString",
                sOper: "searchOper",
                sFilter: "filters",
                loadDefaults: !0,
                beforeShowSearch: null,
                afterShowSearch: null,
                onInitializeSearch: null,
                afterRedraw: null,
                afterChange: null,
                closeAfterSearch: !1,
                closeAfterReset: !1,
                closeOnEscape: !1,
                searchOnEnter: !1,
                multipleSearch: !1,
                multipleGroup: !1,
                top: 0,
                left: 0,
                jqModal: !0,
                modal: !1,
                resize: !0,
                width: 450,
                height: "auto",
                dataheight: "auto",
                showQuery: !1,
                errorcheck: !0,
                sopt: null,
                stringResult: void 0,
                onClose: null,
                onSearch: null,
                onReset: null,
                toTop: !0,
                overlay: 30,
                columns: [],
                tmplNames: null,
                tmplFilters: null,
                tmplLabel: " Template: ",
                showOnLoad: !1,
                layer: null,
                operands: {
                    eq: "=",
                    ne: "<>",
                    lt: "<",
                    le: "<=",
                    gt: ">",
                    ge: ">=",
                    bw: "LIKE",
                    bn: "NOT LIKE",
                    "in": "IN",
                    ni: "NOT IN",
                    ew: "LIKE",
                    en: "NOT LIKE",
                    cn: "LIKE",
                    nc: "NOT LIKE",
                    nu: "IS NULL",
                    nn: "ISNOT NULL"
                }
            }, a.jgrid.search, d || {});
            return this.each(function() {
                function b(b) {
                    h = a(f).triggerHandler("jqGridFilterBeforeShow", [b]);
                    void 0 ===
                        h && (h = !0);
                    h && a.isFunction(d.beforeShowSearch) && (h = d.beforeShowSearch.call(f, b));
                    h && (a.jgrid.viewModal("#" + a.jgrid.jqID(i.themodal), {
                        gbox: "#gbox_" + a.jgrid.jqID(c),
                        jqm: d.jqModal,
                        modal: d.modal,
                        overlay: d.overlay,
                        toTop: d.toTop
                    }), a(f).triggerHandler("jqGridFilterAfterShow", [b]), a.isFunction(d.afterShowSearch) && d.afterShowSearch.call(f, b))
                }
                var f = this;
                if (f.grid) {
                    var c = "fbox_" + f.p.id,
                        h = !0,
                        g = !0,
                        i = {
                            themodal: "searchmod" + c,
                            modalhead: "searchhd" + c,
                            modalcontent: "searchcnt" + c,
                            scrollelm: c
                        },
                        j = f.p.postData[d.sFilter],
                        k;
                    "string" === typeof j && (j = a.jgrid.parse(j));
                    !0 === d.recreateFilter && a("#" + a.jgrid.jqID(i.themodal)).remove();
                    if (void 0 !== a("#" + a.jgrid.jqID(i.themodal))[0]) b(a("#fbox_" + a.jgrid.jqID(+f.p.id)));
                    else {
                        var m = a("<div><div id='" + c + "' class='searchFilter' style='overflow:auto'></div></div>").insertBefore("#gview_" + a.jgrid.jqID(f.p.id)),
                            o = "left",
                            n = "";
                        "rtl" === f.p.direction && (o = "right", n = " style='text-align:left'", m.attr("dir", "rtl"));
                        var l = a.extend([], f.p.colModel),
                            p = "<a id='" + c + "_search' class='fm-button ui-state-default ui-corner-all fm-button-icon-right ui-reset'><span class='ui-icon ui-icon-search'></span>" +
                            d.Find + "</a>",
                            r = "<a id='" + c + "_reset' class='fm-button ui-state-default ui-corner-all fm-button-icon-left ui-search'><span class='ui-icon ui-icon-arrowreturnthick-1-w'></span>" + d.Reset + "</a>",
                            q = "",
                            s = "",
                            t, w = !1,
                            v = -1;
                        d.showQuery && (q = "<a id='" + c + "_query' class='fm-button ui-state-default ui-corner-all fm-button-icon-left'><span class='ui-icon ui-icon-comment'></span>Query</a>");
                        d.columns.length ? (l = d.columns, v = 0, t = l[0].index || l[0].name) : a.each(l, function(a, b) {
                            if (!b.label) b.label = f.p.colNames[a];
                            if (!w) {
                                var c =
                                    b.search === void 0 ? true : b.search,
                                    d = b.hidden === true;
                                if (b.searchoptions && b.searchoptions.searchhidden === true && c || c && !d) {
                                    w = true;
                                    t = b.index || b.name;
                                    v = a
                                }
                            }
                        });
                        if (!j && t || !1 === d.multipleSearch) {
                            var x = "eq";
                            0 <= v && l[v].searchoptions && l[v].searchoptions.sopt ? x = l[v].searchoptions.sopt[0] : d.sopt && d.sopt.length && (x = d.sopt[0]);
                            j = {
                                groupOp: "AND",
                                rules: [{
                                    field: t,
                                    op: x,
                                    data: ""
                                }]
                            }
                        }
                        w = !1;
                        d.tmplNames && d.tmplNames.length && (w = !0, s = d.tmplLabel, s += "<select class='ui-template'>", s += "<option value='default'>Default</option>", a.each(d.tmplNames,
                            function(a, b) {
                                s = s + ("<option value='" + a + "'>" + b + "</option>")
                            }), s += "</select>");
                        o = "<table class='EditTable' style='border:0px none;margin-top:5px' id='" + c + "_2'><tbody><tr><td colspan='2'><hr class='ui-widget-content' style='margin:1px'/></td></tr><tr><td class='EditButton' style='text-align:" + o + "'>" + r + s + "</td><td class='EditButton' " + n + ">" + q + p + "</td></tr></tbody></table>";
                        c = a.jgrid.jqID(c);
                        a("#" + c).jqFilter({
                            columns: l,
                            filter: d.loadDefaults ? j : null,
                            showQuery: d.showQuery,
                            errorcheck: d.errorcheck,
                            sopt: d.sopt,
                            groupButton: d.multipleGroup,
                            ruleButtons: d.multipleSearch,
                            afterRedraw: d.afterRedraw,
                            ops: d.odata,
                            operands: d.operands,
                            ajaxSelectOptions: f.p.ajaxSelectOptions,
                            groupOps: d.groupOps,
                            onChange: function() {
                                this.p.showQuery && a(".query", this).html(this.toUserFriendlyString());
                                a.isFunction(d.afterChange) && d.afterChange.call(f, a("#" + c), d)
                            },
                            direction: f.p.direction,
                            id: f.p.id
                        });
                        m.append(o);
                        w && (d.tmplFilters && d.tmplFilters.length) && a(".ui-template", m).bind("change", function() {
                            var b = a(this).val();
                            b === "default" ? a("#" +
                                c).jqFilter("addFilter", j) : a("#" + c).jqFilter("addFilter", d.tmplFilters[parseInt(b, 10)]);
                            return false
                        });
                        !0 === d.multipleGroup && (d.multipleSearch = !0);
                        a(f).triggerHandler("jqGridFilterInitialize", [a("#" + c)]);
                        a.isFunction(d.onInitializeSearch) && d.onInitializeSearch.call(f, a("#" + c));
                        d.gbox = "#gbox_" + c;
                        d.layer ? a.jgrid.createModal(i, m, d, "#gview_" + a.jgrid.jqID(f.p.id), a("#gbox_" + a.jgrid.jqID(f.p.id))[0], "#" + a.jgrid.jqID(d.layer), {
                            position: "relative"
                        }) : a.jgrid.createModal(i, m, d, "#gview_" + a.jgrid.jqID(f.p.id),
                            a("#gbox_" + a.jgrid.jqID(f.p.id))[0]);
                        (d.searchOnEnter || d.closeOnEscape) && a("#" + a.jgrid.jqID(i.themodal)).keydown(function(b) {
                            var f = a(b.target);
                            if (d.searchOnEnter && b.which === 13 && !f.hasClass("add-group") && !f.hasClass("add-rule") && !f.hasClass("delete-group") && !f.hasClass("delete-rule") && (!f.hasClass("fm-button") || !f.is("[id$=_query]"))) {
                                a("#" + c + "_search").click();
                                return false
                            }
                            if (d.closeOnEscape && b.which === 27) {
                                a("#" + a.jgrid.jqID(i.modalhead)).find(".ui-jqdialog-titlebar-close").click();
                                return false
                            }
                        });
                        q && a("#" + c + "_query").bind("click", function() {
                            a(".queryresult", m).toggle();
                            return false
                        });
                        void 0 === d.stringResult && (d.stringResult = d.multipleSearch);
                        a("#" + c + "_search").bind("click", function() {
                            var b = {},
                                h, j;
                            k = a("#" + c);
                            k.find(".input-elm:focus").change();
                            j = k.jqFilter("filterData");
                            if (d.errorcheck) {
                                k[0].hideError();
                                d.showQuery || k.jqFilter("toSQLString");
                                if (k[0].p.error) {
                                    k[0].showError();
                                    return false
                                }
                            }
                            if (d.stringResult) {
                                try {
                                    h = xmlJsonClass.toJson(j, "", "", false)
                                } catch (l) {
                                    try {
                                        h = JSON.stringify(j)
                                    } catch (m) {}
                                }
                                if (typeof h ===
                                    "string") {
                                    b[d.sFilter] = h;
                                    a.each([d.sField, d.sValue, d.sOper], function() {
                                        b[this] = ""
                                    })
                                }
                            } else if (d.multipleSearch) {
                                b[d.sFilter] = j;
                                a.each([d.sField, d.sValue, d.sOper], function() {
                                    b[this] = ""
                                })
                            } else {
                                b[d.sField] = j.rules[0].field;
                                b[d.sValue] = j.rules[0].data;
                                b[d.sOper] = j.rules[0].op;
                                b[d.sFilter] = ""
                            }
                            f.p.search = true;
                            a.extend(f.p.postData, b);
                            g = a(f).triggerHandler("jqGridFilterSearch");
                            g === void 0 && (g = true);
                            g && a.isFunction(d.onSearch) && (g = d.onSearch.call(f, f.p.filters));
                            g !== false && a(f).trigger("reloadGrid", [{
                                page: 1
                            }]);
                            d.closeAfterSearch && a.jgrid.hideModal("#" + a.jgrid.jqID(i.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(f.p.id),
                                jqm: d.jqModal,
                                onClose: d.onClose
                            });
                            return false
                        });
                        a("#" + c + "_reset").bind("click", function() {
                            var b = {},
                                h = a("#" + c);
                            f.p.search = false;
                            f.p.resetsearch = true;
                            d.multipleSearch === false ? b[d.sField] = b[d.sValue] = b[d.sOper] = "" : b[d.sFilter] = "";
                            h[0].resetFilter();
                            w && a(".ui-template", m).val("default");
                            a.extend(f.p.postData, b);
                            g = a(f).triggerHandler("jqGridFilterReset");
                            g === void 0 && (g = true);
                            g && a.isFunction(d.onReset) &&
                                (g = d.onReset.call(f));
                            g !== false && a(f).trigger("reloadGrid", [{
                                page: 1
                            }]);
                            d.closeAfterReset && a.jgrid.hideModal("#" + a.jgrid.jqID(i.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(f.p.id),
                                jqm: d.jqModal,
                                onClose: d.onClose
                            });
                            return false
                        });
                        b(a("#" + c));
                        a(".fm-button:not(.ui-state-disabled)", m).hover(function() {
                            a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        })
                    }
                }
            })
        },
        editGridRow: function(e, b) {
            b = a.extend(!0, {
                top: 0,
                left: 0,
                width: 300,
                datawidth: "auto",
                height: "auto",
                dataheight: "auto",
                modal: !1,
                overlay: 30,
                drag: !0,
                resize: !0,
                url: null,
                mtype: "POST",
                clearAfterAdd: !0,
                closeAfterEdit: !1,
                reloadAfterSubmit: !0,
                onInitializeForm: null,
                beforeInitData: null,
                beforeShowForm: null,
                afterShowForm: null,
                beforeSubmit: null,
                afterSubmit: null,
                onclickSubmit: null,
                afterComplete: null,
                onclickPgButtons: null,
                afterclickPgButtons: null,
                editData: {},
                recreateForm: !1,
                jqModal: !0,
                closeOnEscape: !1,
                addedrow: "first",
                topinfo: "",
                bottominfo: "",
                saveicon: [],
                closeicon: [],
                savekey: [!1, 13],
                navkeys: [!1, 38, 40],
                checkOnSubmit: !1,
                checkOnUpdate: !1,
                _savedData: {},
                processing: !1,
                onClose: null,
                ajaxEditOptions: {},
                serializeEditData: null,
                viewPagerButtons: !0,
                overlayClass: "ui-widget-overlay"
            }, a.jgrid.edit, b || {});
            d[a(this)[0].p.id] = b;
            return this.each(function() {
                function f() {
                    a(s + " > tbody > tr > td > .FormElement").each(function() {
                        var b = a(".customelement", this);
                        if (b.length) {
                            var c = a(b[0]).attr("name");
                            a.each(l.p.colModel, function() {
                                if (this.name === c && this.editoptions && a.isFunction(this.editoptions.custom_value)) {
                                    try {
                                        if (u[c] = this.editoptions.custom_value.call(l, a("#" + a.jgrid.jqID(c),
                                            s), "get"), void 0 === u[c]) throw "e1";
                                    } catch (b) {
                                        "e1" === b ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.novalue, a.jgrid.edit.bClose) : a.jgrid.info_dialog(a.jgrid.errors.errcap, b.message, a.jgrid.edit.bClose)
                                    }
                                    return !0
                                }
                            })
                        } else {
                            switch (a(this).get(0).type) {
                                case "checkbox":
                                    a(this).is(":checked") ? u[this.name] = a(this).val() : (b = a(this).attr("offval"), u[this.name] = b);
                                    break;
                                case "select-one":
                                    u[this.name] = a("option:selected", this).val();
                                    break;
                                case "select-multiple":
                                    u[this.name] =
                                        a(this).val();
                                    u[this.name] = u[this.name] ? u[this.name].join(",") : "";
                                    a("option:selected", this).each(function(b, c) {
                                        a(c).text()
                                    });
                                    break;
                                case "password":
                                case "text":
                                case "textarea":
                                case "button":
                                    u[this.name] = a(this).val()
                            }
                            l.p.autoencode && (u[this.name] = a.jgrid.htmlEncode(u[this.name]))
                        }
                    });
                    return !0
                }

                function c(b, c, e, f) {
                    var g, i, h, j = 0,
                        k, m, o, n = [],
                        p = !1,
                        y = "",
                        t;
                    for (t = 1; t <= f; t++) y += "<td class='CaptionTD'>&#160;</td><td class='DataTD'>&#160;</td>";
                    "_empty" !== b && (p = a(c).jqGrid("getInd", b));
                    a(c.p.colModel).each(function(t) {
                        g =
                            this.name;
                        m = (i = this.editrules && !0 === this.editrules.edithidden ? !1 : !0 === this.hidden ? !0 : !1) ? "style='display:none'" : "";
                        if ("cb" !== g && "subgrid" !== g && !0 === this.editable && "rn" !== g) {
                            if (!1 === p) k = "";
                            else if (g === c.p.ExpandColumn && !0 === c.p.treeGrid) k = a("td[role='gridcell']:eq(" + t + ")", c.rows[p]).text();
                            else {
                                try {
                                    k = a.unformat.call(c, a("td[role='gridcell']:eq(" + t + ")", c.rows[p]), {
                                        rowId: b,
                                        colModel: this
                                    }, t)
                                } catch (v) {
                                    k = this.edittype && "textarea" === this.edittype ? a("td[role='gridcell']:eq(" + t + ")", c.rows[p]).text() : a("td[role='gridcell']:eq(" +
                                        t + ")", c.rows[p]).html()
                                }
                                if (!k || "&nbsp;" === k || "&#160;" === k || 1 === k.length && 160 === k.charCodeAt(0)) k = ""
                            }
                            var q = a.extend({}, this.editoptions || {}, {
                                    id: g,
                                    name: g,
                                    rowId: b
                                }),
                                s = a.extend({}, {
                                    elmprefix: "",
                                    elmsuffix: "",
                                    rowabove: !1,
                                    rowcontent: ""
                                }, this.formoptions || {}),
                                w = parseInt(s.rowpos, 10) || j + 1,
                                x = parseInt(2 * (parseInt(s.colpos, 10) || 1), 10);
                            "_empty" === b && q.defaultValue && (k = a.isFunction(q.defaultValue) ? q.defaultValue.call(l) : q.defaultValue);
                            this.edittype || (this.edittype = "text");
                            l.p.autoencode && (k = a.jgrid.htmlDecode(k));
                            o = a.jgrid.createEl.call(l, this.edittype, q, k, !1, a.extend({}, a.jgrid.ajaxOptions, c.p.ajaxSelectOptions || {}));
                            if (d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate) d[l.p.id]._savedData[g] = k;
                            a(o).addClass("FormElement"); - 1 < a.inArray(this.edittype, ["text", "textarea", "password", "select"]) && a(o).addClass("ui-widget-content ui-corner-all");
                            h = a(e).find("tr[rowpos=" + w + "]");
                            if (s.rowabove) {
                                var u = a("<tr><td class='contentinfo' colspan='" + 2 * f + "'>" + s.rowcontent + "</td></tr>");
                                a(e).append(u);
                                u[0].rp = w
                            }
                            0 === h.length &&
                                (h = a("<tr " + m + " rowpos='" + w + "'></tr>").addClass("FormData").attr("id", "tr_" + g), a(h).append(y), a(e).append(h), h[0].rp = w);
                            a("td:eq(" + (x - 2) + ")", h[0]).html(void 0 === s.label ? c.p.colNames[t] : s.label);
                            a("td:eq(" + (x - 1) + ")", h[0]).append(s.elmprefix).append(o).append(s.elmsuffix);
                            "custom" === this.edittype && a.isFunction(q.custom_value) && q.custom_value.call(l, a("#" + g, "#" + r), "set", k);
                            a.jgrid.bindEv.call(l, o, q);
                            n[j] = t;
                            j++
                        }
                    });
                    if (0 < j && (t = a("<tr class='FormData' style='display:none'><td class='CaptionTD'></td><td colspan='" +
                        (2 * f - 1) + "' class='DataTD'><input class='FormElement' id='id_g' type='text' name='" + c.p.id + "_id' value='" + b + "'/></td></tr>"), t[0].rp = j + 999, a(e).append(t), d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate)) d[l.p.id]._savedData[c.p.id + "_id"] = b;
                    return n
                }

                function h(b, c, e) {
                    var f, g = 0,
                        i, h, j, k, m;
                    if (d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate) d[l.p.id]._savedData = {}, d[l.p.id]._savedData[c.p.id + "_id"] = b;
                    var o = c.p.colModel;
                    if ("_empty" === b) a(o).each(function() {
                        f = this.name;
                        j = a.extend({}, this.editoptions || {});
                        if ((h = a("#" + a.jgrid.jqID(f), "#" + e)) && h.length && null !== h[0])
                            if (k = "", "custom" === this.edittype && a.isFunction(j.custom_value) ? j.custom_value.call(l, a("#" + f, "#" + e), "set", k) : j.defaultValue ? (k = a.isFunction(j.defaultValue) ? j.defaultValue.call(l) : j.defaultValue, "checkbox" === h[0].type ? (m = k.toLowerCase(), 0 > m.search(/(false|f|0|no|n|off|undefined)/i) && "" !== m ? (h[0].checked = !0, h[0].defaultChecked = !0, h[0].value = k) : (h[0].checked = !1, h[0].defaultChecked = !1)) : h.val(k)) : "checkbox" === h[0].type ? (h[0].checked = !1, h[0].defaultChecked = !1, k = a(h).attr("offval")) : h[0].type && "select" === h[0].type.substr(0, 6) ? h[0].selectedIndex = 0 : h.val(k), !0 === d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate) d[l.p.id]._savedData[f] = k
                    }), a("#id_g", "#" + e).val(b);
                    else {
                        var n = a(c).jqGrid("getInd", b, !0);
                        n && (a('td[role="gridcell"]', n).each(function(h) {
                            f = o[h].name;
                            if ("cb" !== f && "subgrid" !== f && "rn" !== f && !0 === o[h].editable) {
                                if (f === c.p.ExpandColumn && !0 === c.p.treeGrid) i = a(this).text();
                                else try {
                                    i = a.unformat.call(c, a(this), {
                                        rowId: b,
                                        colModel: o[h]
                                    }, h)
                                } catch (j) {
                                    i = "textarea" ===
                                        o[h].edittype ? a(this).text() : a(this).html()
                                }
                                l.p.autoencode && (i = a.jgrid.htmlDecode(i));
                                if (!0 === d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate) d[l.p.id]._savedData[f] = i;
                                f = a.jgrid.jqID(f);
                                switch (o[h].edittype) {
                                    case "password":
                                    case "text":
                                    case "button":
                                    case "image":
                                    case "textarea":
                                        if ("&nbsp;" === i || "&#160;" === i || 1 === i.length && 160 === i.charCodeAt(0)) i = "";
                                        a("#" + f, "#" + e).val(i);
                                        break;
                                    case "select":
                                        var k = i.split(","),
                                            k = a.map(k, function(b) {
                                                return a.trim(b)
                                            });
                                        a("#" + f + " option", "#" + e).each(function() {
                                            this.selected = !o[h].editoptions.multiple && (a.trim(i) === a.trim(a(this).text()) || k[0] === a.trim(a(this).text()) || k[0] === a.trim(a(this).val())) ? !0 : o[h].editoptions.multiple ? -1 < a.inArray(a.trim(a(this).text()), k) || -1 < a.inArray(a.trim(a(this).val()), k) ? !0 : !1 : !1
                                        });
                                        break;
                                    case "checkbox":
                                        i = "" + i;
                                        if (o[h].editoptions && o[h].editoptions.value)
                                            if (o[h].editoptions.value.split(":")[0] === i) a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]({
                                                checked: !0,
                                                defaultChecked: !0
                                            });
                                            else a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]({
                                                checked: !1,
                                                defaultChecked: !1
                                            });
                                        else i = i.toLowerCase(), 0 > i.search(/(false|f|0|no|n|off|undefined)/i) && "" !== i ? (a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]("checked", !0), a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]("defaultChecked", !0)) : (a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]("checked", !1), a("#" + f, "#" + e)[l.p.useProp ? "prop" : "attr"]("defaultChecked", !1));
                                        break;
                                    case "custom":
                                        try {
                                            if (o[h].editoptions && a.isFunction(o[h].editoptions.custom_value)) o[h].editoptions.custom_value.call(l, a("#" + f, "#" + e), "set", i);
                                            else throw "e1";
                                        } catch (m) {
                                            "e1" ===
                                            m ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.nodefined, a.jgrid.edit.bClose) : a.jgrid.info_dialog(a.jgrid.errors.errcap, m.message, a.jgrid.edit.bClose)
                                        }
                                }
                                g++
                            }
                        }), 0 < g && a("#id_g", s).val(b))
                    }
                }

                function g() {
                    a.each(l.p.colModel, function(a, b) {
                        b.editoptions && !0 === b.editoptions.NullIfEmpty && u.hasOwnProperty(b.name) && "" === u[b.name] && (u[b.name] = "null")
                    })
                }

                function i() {
                    var c, e = [!0, "", ""],
                        f = {},
                        i = l.p.prmNames,
                        j, k, m, o, n, y = a(l).triggerHandler("jqGridAddEditBeforeCheckValues", [a("#" + r), B]);
                    y && "object" === typeof y && (u = y);
                    a.isFunction(d[l.p.id].beforeCheckValues) && (y = d[l.p.id].beforeCheckValues.call(l, u, a("#" + r), B)) && "object" === typeof y && (u = y);
                    for (m in u)
                        if (u.hasOwnProperty(m) && (e = a.jgrid.checkValues.call(l, u[m], m), !1 === e[0])) break;
                    g();
                    e[0] && (f = a(l).triggerHandler("jqGridAddEditClickSubmit", [d[l.p.id], u, B]), void 0 === f && a.isFunction(d[l.p.id].onclickSubmit) && (f = d[l.p.id].onclickSubmit.call(l, d[l.p.id], u, B) || {}), e = a(l).triggerHandler("jqGridAddEditBeforeSubmit", [u, a("#" + r),
                        B
                    ]), void 0 === e && (e = [!0, "", ""]), e[0] && a.isFunction(d[l.p.id].beforeSubmit) && (e = d[l.p.id].beforeSubmit.call(l, u, a("#" + r), B)));
                    if (e[0] && !d[l.p.id].processing) {
                        d[l.p.id].processing = !0;
                        a("#sData", s + "_2").addClass("ui-state-active");
                        k = i.oper;
                        j = i.id;
                        u[k] = "_empty" === a.trim(u[l.p.id + "_id"]) ? i.addoper : i.editoper;
                        u[k] !== i.addoper ? u[j] = u[l.p.id + "_id"] : void 0 === u[j] && (u[j] = u[l.p.id + "_id"]);
                        delete u[l.p.id + "_id"];
                        u = a.extend(u, d[l.p.id].editData, f);
                        if (!0 === l.p.treeGrid)
                            for (n in u[k] === i.addoper && (o = a(l).jqGrid("getGridParam",
                                "selrow"), u["adjacency" === l.p.treeGridModel ? l.p.treeReader.parent_id_field : "parent_id"] = o), l.p.treeReader) l.p.treeReader.hasOwnProperty(n) && (f = l.p.treeReader[n], u.hasOwnProperty(f) && !(u[k] === i.addoper && "parent_id_field" === n) && delete u[f]);
                        u[j] = a.jgrid.stripPref(l.p.idPrefix, u[j]);
                        n = a.extend({
                            url: d[l.p.id].url || a(l).jqGrid("getGridParam", "editurl"),
                            type: d[l.p.id].mtype,
                            data: a.isFunction(d[l.p.id].serializeEditData) ? d[l.p.id].serializeEditData.call(l, u) : u,
                            complete: function(f, g) {
                                var m;
                                u[j] = l.p.idPrefix +
                                    u[j];
                                if (f.status >= 300 && f.status !== 304) {
                                    e[0] = false;
                                    e[1] = a(l).triggerHandler("jqGridAddEditErrorTextFormat", [f, B]);
                                    e[1] = a.isFunction(d[l.p.id].errorTextFormat) ? d[l.p.id].errorTextFormat.call(l, f, B) : g + " Status: '" + f.statusText + "'. Error code: " + f.status
                                } else {
                                    e = a(l).triggerHandler("jqGridAddEditAfterSubmit", [f, u, B]);
                                    e === void 0 && (e = [true, "", ""]);
                                    e[0] && a.isFunction(d[l.p.id].afterSubmit) && (e = d[l.p.id].afterSubmit.call(l, f, u, B))
                                } if (e[0] === false) {
                                    a("#FormError>td", s).html(e[1]);
                                    a("#FormError", s).show()
                                } else {
                                    l.p.autoencode &&
                                        a.each(u, function(b, c) {
                                            u[b] = a.jgrid.htmlDecode(c)
                                        });
                                    if (u[k] === i.addoper) {
                                        e[2] || (e[2] = a.jgrid.randId());
                                        u[j] = e[2];
                                        d[l.p.id].reloadAfterSubmit ? a(l).trigger("reloadGrid") : l.p.treeGrid === true ? a(l).jqGrid("addChildNode", e[2], o, u) : a(l).jqGrid("addRowData", e[2], u, b.addedrow);
                                        if (d[l.p.id].closeAfterAdd) {
                                            l.p.treeGrid !== true && a(l).jqGrid("setSelection", e[2]);
                                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                                gb: "#gbox_" + a.jgrid.jqID(p),
                                                jqm: b.jqModal,
                                                onClose: d[l.p.id].onClose
                                            })
                                        } else d[l.p.id].clearAfterAdd && h("_empty",
                                            l, r)
                                    } else {
                                        if (d[l.p.id].reloadAfterSubmit) {
                                            a(l).trigger("reloadGrid");
                                            d[l.p.id].closeAfterEdit || setTimeout(function() {
                                                a(l).jqGrid("setSelection", u[j])
                                            }, 1E3)
                                        } else l.p.treeGrid === true ? a(l).jqGrid("setTreeRow", u[j], u) : a(l).jqGrid("setRowData", u[j], u);
                                        d[l.p.id].closeAfterEdit && a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                            gb: "#gbox_" + a.jgrid.jqID(p),
                                            jqm: b.jqModal,
                                            onClose: d[l.p.id].onClose
                                        })
                                    } if (a.isFunction(d[l.p.id].afterComplete)) {
                                        c = f;
                                        setTimeout(function() {
                                            a(l).triggerHandler("jqGridAddEditAfterComplete", [c, u, a("#" + r), B]);
                                            d[l.p.id].afterComplete.call(l, c, u, a("#" + r), B);
                                            c = null
                                        }, 500)
                                    }
                                    if (d[l.p.id].checkOnSubmit || d[l.p.id].checkOnUpdate) {
                                        a("#" + r).data("disabled", false);
                                        if (d[l.p.id]._savedData[l.p.id + "_id"] !== "_empty")
                                            for (m in d[l.p.id]._savedData) d[l.p.id]._savedData.hasOwnProperty(m) && u[m] && (d[l.p.id]._savedData[m] = u[m])
                                    }
                                }
                                d[l.p.id].processing = false;
                                a("#sData", s + "_2").removeClass("ui-state-active");
                                try {
                                    a(":input:visible", "#" + r)[0].focus()
                                } catch (n) {}
                            }
                        }, a.jgrid.ajaxOptions, d[l.p.id].ajaxEditOptions);
                        !n.url &&
                            !d[l.p.id].useDataProxy && (a.isFunction(l.p.dataProxy) ? d[l.p.id].useDataProxy = !0 : (e[0] = !1, e[1] += " " + a.jgrid.errors.nourl));
                        e[0] && (d[l.p.id].useDataProxy ? (f = l.p.dataProxy.call(l, n, "set_" + l.p.id), void 0 === f && (f = [!0, ""]), !1 === f[0] ? (e[0] = !1, e[1] = f[1] || "Error deleting the selected row!") : (n.data.oper === i.addoper && d[l.p.id].closeAfterAdd && a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            }), n.data.oper === i.editoper && d[l.p.id].closeAfterEdit &&
                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            }))) : "clientArray" === n.url ? (u = n.data, n.complete({
                            status: 200,
                            statusText: ""
                        }, "")) : a.ajax(n))
                    }!1 === e[0] && (a("#FormError>td", s).html(e[1]), a("#FormError", s).show())
                }

                function j(a, b) {
                    var c = !1,
                        d;
                    for (d in a)
                        if (a.hasOwnProperty(d) && a[d] != b[d]) {
                            c = !0;
                            break
                        }
                    return c
                }

                function k() {
                    var b = !0;
                    a("#FormError", s).hide();
                    if (d[l.p.id].checkOnUpdate && (u = {}, f(), A = j(u, d[l.p.id]._savedData))) a("#" + r).data("disabled", !0), a(".confirm", "#" + t.themodal).show(), b = !1;
                    return b
                }

                function m() {
                    var b;
                    if ("_empty" !== e && void 0 !== l.p.savedRow && 0 < l.p.savedRow.length && a.isFunction(a.fn.jqGrid.restoreRow))
                        for (b = 0; b < l.p.savedRow.length; b++)
                            if (l.p.savedRow[b].id == e) {
                                a(l).jqGrid("restoreRow", e);
                                break
                            }
                }

                function o(b, c) {
                    var d = c[1].length - 1;
                    0 === b ? a("#pData", s + "_2").addClass("ui-state-disabled") : void 0 !== c[1][b - 1] && a("#" + a.jgrid.jqID(c[1][b - 1])).hasClass("ui-state-disabled") ? a("#pData", s + "_2").addClass("ui-state-disabled") : a("#pData", s +
                        "_2").removeClass("ui-state-disabled");
                    b === d ? a("#nData", s + "_2").addClass("ui-state-disabled") : void 0 !== c[1][b + 1] && a("#" + a.jgrid.jqID(c[1][b + 1])).hasClass("ui-state-disabled") ? a("#nData", s + "_2").addClass("ui-state-disabled") : a("#nData", s + "_2").removeClass("ui-state-disabled")
                }

                function n() {
                    var b = a(l).jqGrid("getDataIDs"),
                        c = a("#id_g", s).val();
                    return [a.inArray(c, b), b]
                }
                var l = this;
                if (l.grid && e) {
                    var p = l.p.id,
                        r = "FrmGrid_" + p,
                        q = "TblGrid_" + p,
                        s = "#" + a.jgrid.jqID(q),
                        t = {
                            themodal: "editmod" + p,
                            modalhead: "edithd" + p,
                            modalcontent: "editcnt" + p,
                            scrollelm: r
                        },
                        w = a.isFunction(d[l.p.id].beforeShowForm) ? d[l.p.id].beforeShowForm : !1,
                        v = a.isFunction(d[l.p.id].afterShowForm) ? d[l.p.id].afterShowForm : !1,
                        x = a.isFunction(d[l.p.id].beforeInitData) ? d[l.p.id].beforeInitData : !1,
                        H = a.isFunction(d[l.p.id].onInitializeForm) ? d[l.p.id].onInitializeForm : !1,
                        y = !0,
                        D = 1,
                        z = 0,
                        u, A, B, r = a.jgrid.jqID(r);
                    "new" === e ? (e = "_empty", B = "add", b.caption = d[l.p.id].addCaption) : (b.caption = d[l.p.id].editCaption, B = "edit");
                    b.recreateForm || a(l).data("formProp") && a.extend(d[a(this)[0].p.id],
                        a(l).data("formProp"));
                    var O = !0;
                    b.checkOnUpdate && (b.jqModal && !b.modal) && (O = !1);
                    var N = isNaN(d[a(this)[0].p.id].dataheight) ? d[a(this)[0].p.id].dataheight : d[a(this)[0].p.id].dataheight + "px",
                        y = isNaN(d[a(this)[0].p.id].datawidth) ? d[a(this)[0].p.id].datawidth : d[a(this)[0].p.id].datawidth + "px",
                        N = a("<form name='FormPost' id='" + r + "' class='FormGrid' onSubmit='return false;' style='width:" + y + ";overflow:auto;position:relative;height:" + N + ";'></form>").data("disabled", !1),
                        U = a("<table id='" + q + "' class='EditTable' cellspacing='0' cellpadding='0' border='0'><tbody></tbody></table>");
                    a(l.p.colModel).each(function() {
                        var a = this.formoptions;
                        D = Math.max(D, a ? a.colpos || 0 : 0);
                        z = Math.max(z, a ? a.rowpos || 0 : 0)
                    });
                    a(N).append(U);
                    y = a("<tr id='FormError' style='display:none'><td class='ui-state-error' colspan='" + 2 * D + "'></td></tr>");
                    y[0].rp = 0;
                    a(U).append(y);
                    y = a("<tr style='display:none' class='tinfo'><td class='topinfo' colspan='" + 2 * D + "'>" + d[l.p.id].topinfo + "</td></tr>");
                    y[0].rp = 0;
                    a(U).append(y);
                    y = a(l).triggerHandler("jqGridAddEditBeforeInitData", [N, B]);
                    void 0 === y && (y = !0);
                    y && x && (y = x.call(l, N, B));
                    if (!1 !== y) {
                        m();
                        var y = (x = "rtl" === l.p.direction ? !0 : !1) ? "nData" : "pData",
                            F = x ? "pData" : "nData";
                        c(e, l, U, D);
                        var y = "<a id='" + y + "' class='fm-button ui-state-default ui-corner-left'><span class='ui-icon ui-icon-triangle-1-w'></span></a>",
                            F = "<a id='" + F + "' class='fm-button ui-state-default ui-corner-right'><span class='ui-icon ui-icon-triangle-1-e'></span></a>",
                            Y = "<a id='sData' class='fm-button ui-state-default ui-corner-all'>" + b.bSubmit + "</a>",
                            R = "<a id='cData' class='fm-button ui-state-default ui-corner-all'>" +
                            b.bCancel + "</a>",
                            q = "<table border='0' cellspacing='0' cellpadding='0' class='EditTable' id='" + q + "_2'><tbody><tr><td colspan='2'><hr class='ui-widget-content' style='margin:1px'/></td></tr><tr id='Act_Buttons'><td class='navButton'>" + (x ? F + y : y + F) + "</td><td class='EditButton'>" + Y + R + "</td></tr>" + ("<tr style='display:none' class='binfo'><td class='bottominfo' colspan='2'>" + d[l.p.id].bottominfo + "</td></tr>"),
                            q = q + "</tbody></table>";
                        if (0 < z) {
                            var Z = [];
                            a.each(a(U)[0].rows, function(a, b) {
                                Z[a] = b
                            });
                            Z.sort(function(a,
                                b) {
                                return a.rp > b.rp ? 1 : a.rp < b.rp ? -1 : 0
                            });
                            a.each(Z, function(b, c) {
                                a("tbody", U).append(c)
                            })
                        }
                        b.gbox = "#gbox_" + a.jgrid.jqID(p);
                        var ca = !1;
                        !0 === b.closeOnEscape && (b.closeOnEscape = !1, ca = !0);
                        q = a("<div></div>").append(N).append(q);
                        a.jgrid.createModal(t, q, d[a(this)[0].p.id], "#gview_" + a.jgrid.jqID(l.p.id), a("#gbox_" + a.jgrid.jqID(l.p.id))[0]);
                        x && (a("#pData, #nData", s + "_2").css("float", "right"), a(".EditButton", s + "_2").css("text-align", "left"));
                        d[l.p.id].topinfo && a(".tinfo", s).show();
                        d[l.p.id].bottominfo && a(".binfo",
                            s + "_2").show();
                        q = q = null;
                        a("#" + a.jgrid.jqID(t.themodal)).keydown(function(c) {
                            var e = c.target;
                            if (a("#" + r).data("disabled") === true) return false;
                            if (d[l.p.id].savekey[0] === true && c.which === d[l.p.id].savekey[1] && e.tagName !== "TEXTAREA") {
                                a("#sData", s + "_2").trigger("click");
                                return false
                            }
                            if (c.which === 27) {
                                if (!k()) return false;
                                ca && a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                    gb: b.gbox,
                                    jqm: b.jqModal,
                                    onClose: d[l.p.id].onClose
                                });
                                return false
                            }
                            if (d[l.p.id].navkeys[0] === true) {
                                if (a("#id_g", s).val() === "_empty") return true;
                                if (c.which === d[l.p.id].navkeys[1]) {
                                    a("#pData", s + "_2").trigger("click");
                                    return false
                                }
                                if (c.which === d[l.p.id].navkeys[2]) {
                                    a("#nData", s + "_2").trigger("click");
                                    return false
                                }
                            }
                        });
                        b.checkOnUpdate && (a("a.ui-jqdialog-titlebar-close span", "#" + a.jgrid.jqID(t.themodal)).removeClass("jqmClose"), a("a.ui-jqdialog-titlebar-close", "#" + a.jgrid.jqID(t.themodal)).unbind("click").click(function() {
                            if (!k()) return false;
                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            });
                            return false
                        }));
                        b.saveicon = a.extend([!0, "left", "ui-icon-disk"], b.saveicon);
                        b.closeicon = a.extend([!0, "left", "ui-icon-close"], b.closeicon);
                        !0 === b.saveicon[0] && a("#sData", s + "_2").addClass("right" === b.saveicon[1] ? "fm-button-icon-right" : "fm-button-icon-left").append("<span class='ui-icon " + b.saveicon[2] + "'></span>");
                        !0 === b.closeicon[0] && a("#cData", s + "_2").addClass("right" === b.closeicon[1] ? "fm-button-icon-right" : "fm-button-icon-left").append("<span class='ui-icon " + b.closeicon[2] + "'></span>");
                        if (d[l.p.id].checkOnSubmit ||
                            d[l.p.id].checkOnUpdate) Y = "<a id='sNew' class='fm-button ui-state-default ui-corner-all' style='z-index:1002'>" + b.bYes + "</a>", F = "<a id='nNew' class='fm-button ui-state-default ui-corner-all' style='z-index:1002'>" + b.bNo + "</a>", R = "<a id='cNew' class='fm-button ui-state-default ui-corner-all' style='z-index:1002'>" + b.bExit + "</a>", q = b.zIndex || 999, q++, a("<div class='" + b.overlayClass + " jqgrid-overlay confirm' style='z-index:" + q + ";display:none;'>&#160;</div><div class='confirm ui-widget-content ui-jqconfirm' style='z-index:" +
                            (q + 1) + "'>" + b.saveData + "<br/><br/>" + Y + F + R + "</div>").insertAfter("#" + r), a("#sNew", "#" + a.jgrid.jqID(t.themodal)).click(function() {
                            i();
                            a("#" + r).data("disabled", false);
                            a(".confirm", "#" + a.jgrid.jqID(t.themodal)).hide();
                            return false
                        }), a("#nNew", "#" + a.jgrid.jqID(t.themodal)).click(function() {
                            a(".confirm", "#" + a.jgrid.jqID(t.themodal)).hide();
                            a("#" + r).data("disabled", false);
                            setTimeout(function() {
                                a(":input:visible", "#" + r)[0].focus()
                            }, 0);
                            return false
                        }), a("#cNew", "#" + a.jgrid.jqID(t.themodal)).click(function() {
                            a(".confirm",
                                "#" + a.jgrid.jqID(t.themodal)).hide();
                            a("#" + r).data("disabled", false);
                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            });
                            return false
                        });
                        a(l).triggerHandler("jqGridAddEditInitializeForm", [a("#" + r), B]);
                        H && H.call(l, a("#" + r), B);
                        "_empty" === e || !d[l.p.id].viewPagerButtons ? a("#pData,#nData", s + "_2").hide() : a("#pData,#nData", s + "_2").show();
                        a(l).triggerHandler("jqGridAddEditBeforeShowForm", [a("#" + r), B]);
                        w && w.call(l, a("#" + r), B);
                        a("#" + a.jgrid.jqID(t.themodal)).data("onClose",
                            d[l.p.id].onClose);
                        a.jgrid.viewModal("#" + a.jgrid.jqID(t.themodal), {
                            gbox: "#gbox_" + a.jgrid.jqID(p),
                            jqm: b.jqModal,
                            overlay: b.overlay,
                            modal: b.modal,
                            overlayClass: b.overlayClass,
                            onHide: function(b) {
                                var c = a("#editmod" + p)[0].style.height;
                                c.indexOf("px") > -1 && (c = parseFloat(c));
                                a(l).data("formProp", {
                                    top: parseFloat(a(b.w).css("top")),
                                    left: parseFloat(a(b.w).css("left")),
                                    width: a(b.w).width(),
                                    height: c,
                                    dataheight: a("#" + r).height(),
                                    datawidth: a("#" + r).width()
                                });
                                b.w.remove();
                                b.o && b.o.remove()
                            }
                        });
                        O || a("." + a.jgrid.jqID(b.overlayClass)).click(function() {
                            if (!k()) return false;
                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            });
                            return false
                        });
                        a(".fm-button", "#" + a.jgrid.jqID(t.themodal)).hover(function() {
                            a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        });
                        a("#sData", s + "_2").click(function() {
                            u = {};
                            a("#FormError", s).hide();
                            f();
                            if (u[l.p.id + "_id"] === "_empty") i();
                            else if (b.checkOnSubmit === true)
                                if (A = j(u, d[l.p.id]._savedData)) {
                                    a("#" + r).data("disabled", true);
                                    a(".confirm", "#" + a.jgrid.jqID(t.themodal)).show()
                                } else i();
                            else i();
                            return false
                        });
                        a("#cData", s + "_2").click(function() {
                            if (!k()) return false;
                            a.jgrid.hideModal("#" + a.jgrid.jqID(t.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(p),
                                jqm: b.jqModal,
                                onClose: d[l.p.id].onClose
                            });
                            return false
                        });
                        a("#nData", s + "_2").click(function() {
                            if (!k()) return false;
                            a("#FormError", s).hide();
                            var c = n();
                            c[0] = parseInt(c[0], 10);
                            if (c[0] !== -1 && c[1][c[0] + 1]) {
                                a(l).triggerHandler("jqGridAddEditClickPgButtons", ["next", a("#" + r), c[1][c[0]]]);
                                var d;
                                if (a.isFunction(b.onclickPgButtons)) {
                                    d = b.onclickPgButtons.call(l,
                                        "next", a("#" + r), c[1][c[0]]);
                                    if (d !== void 0 && d === false) return false
                                }
                                if (a("#" + a.jgrid.jqID(c[1][c[0] + 1])).hasClass("ui-state-disabled")) return false;
                                h(c[1][c[0] + 1], l, r);
                                a(l).jqGrid("setSelection", c[1][c[0] + 1]);
                                a(l).triggerHandler("jqGridAddEditAfterClickPgButtons", ["next", a("#" + r), c[1][c[0]]]);
                                a.isFunction(b.afterclickPgButtons) && b.afterclickPgButtons.call(l, "next", a("#" + r), c[1][c[0] + 1]);
                                o(c[0] + 1, c)
                            }
                            return false
                        });
                        a("#pData", s + "_2").click(function() {
                            if (!k()) return false;
                            a("#FormError", s).hide();
                            var c =
                                n();
                            if (c[0] !== -1 && c[1][c[0] - 1]) {
                                a(l).triggerHandler("jqGridAddEditClickPgButtons", ["prev", a("#" + r), c[1][c[0]]]);
                                var d;
                                if (a.isFunction(b.onclickPgButtons)) {
                                    d = b.onclickPgButtons.call(l, "prev", a("#" + r), c[1][c[0]]);
                                    if (d !== void 0 && d === false) return false
                                }
                                if (a("#" + a.jgrid.jqID(c[1][c[0] - 1])).hasClass("ui-state-disabled")) return false;
                                h(c[1][c[0] - 1], l, r);
                                a(l).jqGrid("setSelection", c[1][c[0] - 1]);
                                a(l).triggerHandler("jqGridAddEditAfterClickPgButtons", ["prev", a("#" + r), c[1][c[0]]]);
                                a.isFunction(b.afterclickPgButtons) &&
                                    b.afterclickPgButtons.call(l, "prev", a("#" + r), c[1][c[0] - 1]);
                                o(c[0] - 1, c)
                            }
                            return false
                        });
                        a(l).triggerHandler("jqGridAddEditAfterShowForm", [a("#" + r), B]);
                        v && v.call(l, a("#" + r), B);
                        w = n();
                        o(w[0], w)
                    }
                }
            })
        },
        viewGridRow: function(e, b) {
            b = a.extend(!0, {
                    top: 0,
                    left: 0,
                    width: 0,
                    datawidth: "auto",
                    height: "auto",
                    dataheight: "auto",
                    modal: !1,
                    overlay: 30,
                    drag: !0,
                    resize: !0,
                    jqModal: !0,
                    closeOnEscape: !1,
                    labelswidth: "30%",
                    closeicon: [],
                    navkeys: [!1, 38, 40],
                    onClose: null,
                    beforeShowForm: null,
                    beforeInitData: null,
                    viewPagerButtons: !0,
                    recreateForm: !1
                },
                a.jgrid.view, b || {});
            d[a(this)[0].p.id] = b;
            return this.each(function() {
                function f() {
                    (!0 === d[j.p.id].closeOnEscape || !0 === d[j.p.id].navkeys[0]) && setTimeout(function() {
                        a(".ui-jqdialog-titlebar-close", "#" + a.jgrid.jqID(p.modalhead)).attr("tabindex", "-1").focus()
                    }, 0)
                }

                function c(c, d, e, f) {
                    var g, i, h, j = 0,
                        k, l, m = [],
                        o = !1,
                        n, p = "<td class='CaptionTD form-view-label ui-widget-content' width='" + b.labelswidth + "'>&#160;</td><td class='DataTD form-view-data ui-helper-reset ui-widget-content'>&#160;</td>",
                        t = "",
                        r = ["integer",
                            "number", "currency"
                        ],
                        q = 0,
                        s = 0,
                        v, w, x;
                    for (n = 1; n <= f; n++) t += 1 === n ? p : "<td class='CaptionTD form-view-label ui-widget-content'>&#160;</td><td class='DataTD form-view-data ui-widget-content'>&#160;</td>";
                    a(d.p.colModel).each(function() {
                        i = this.editrules && !0 === this.editrules.edithidden ? !1 : !0 === this.hidden ? !0 : !1;
                        !i && "right" === this.align && (this.formatter && -1 !== a.inArray(this.formatter, r) ? q = Math.max(q, parseInt(this.width, 10)) : s = Math.max(s, parseInt(this.width, 10)))
                    });
                    v = 0 !== q ? q : 0 !== s ? s : 0;
                    o = a(d).jqGrid("getInd",
                        c);
                    a(d.p.colModel).each(function(b) {
                        g = this.name;
                        w = !1;
                        l = (i = this.editrules && !0 === this.editrules.edithidden ? !1 : !0 === this.hidden ? !0 : !1) ? "style='display:none'" : "";
                        x = "boolean" !== typeof this.viewable ? !0 : this.viewable;
                        if ("cb" !== g && "subgrid" !== g && "rn" !== g && x) {
                            k = !1 === o ? "" : g === d.p.ExpandColumn && !0 === d.p.treeGrid ? a("td:eq(" + b + ")", d.rows[o]).text() : a("td:eq(" + b + ")", d.rows[o]).html();
                            w = "right" === this.align && 0 !== v ? !0 : !1;
                            var c = a.extend({}, {
                                    rowabove: !1,
                                    rowcontent: ""
                                }, this.formoptions || {}),
                                n = parseInt(c.rowpos, 10) ||
                                j + 1,
                                p = parseInt(2 * (parseInt(c.colpos, 10) || 1), 10);
                            if (c.rowabove) {
                                var y = a("<tr><td class='contentinfo' colspan='" + 2 * f + "'>" + c.rowcontent + "</td></tr>");
                                a(e).append(y);
                                y[0].rp = n
                            }
                            h = a(e).find("tr[rowpos=" + n + "]");
                            0 === h.length && (h = a("<tr " + l + " rowpos='" + n + "'></tr>").addClass("FormData").attr("id", "trv_" + g), a(h).append(t), a(e).append(h), h[0].rp = n);
                            a("td:eq(" + (p - 2) + ")", h[0]).html("<b>" + (void 0 === c.label ? d.p.colNames[b] : c.label) + "</b>");
                            a("td:eq(" + (p - 1) + ")", h[0]).append("<span>" + k + "</span>").attr("id", "v_" + g);
                            w && a("td:eq(" + (p - 1) + ") span", h[0]).css({
                                "text-align": "right",
                                width: v + "px"
                            });
                            m[j] = b;
                            j++
                        }
                    });
                    0 < j && (c = a("<tr class='FormData' style='display:none'><td class='CaptionTD'></td><td colspan='" + (2 * f - 1) + "' class='DataTD'><input class='FormElement' id='id_g' type='text' name='id' value='" + c + "'/></td></tr>"), c[0].rp = j + 99, a(e).append(c));
                    return m
                }

                function h(b, c) {
                    var d, e, f = 0,
                        g, i;
                    if (i = a(c).jqGrid("getInd", b, !0)) a("td", i).each(function(b) {
                        d = c.p.colModel[b].name;
                        e = c.p.colModel[b].editrules && !0 === c.p.colModel[b].editrules.edithidden ?
                            !1 : !0 === c.p.colModel[b].hidden ? !0 : !1;
                        "cb" !== d && ("subgrid" !== d && "rn" !== d) && (g = d === c.p.ExpandColumn && !0 === c.p.treeGrid ? a(this).text() : a(this).html(), d = a.jgrid.jqID("v_" + d), a("#" + d + " span", "#" + o).html(g), e && a("#" + d, "#" + o).parents("tr:first").hide(), f++)
                    }), 0 < f && a("#id_g", "#" + o).val(b)
                }

                function g(b, c) {
                    var d = c[1].length - 1;
                    0 === b ? a("#pData", "#" + o + "_2").addClass("ui-state-disabled") : void 0 !== c[1][b - 1] && a("#" + a.jgrid.jqID(c[1][b - 1])).hasClass("ui-state-disabled") ? a("#pData", o + "_2").addClass("ui-state-disabled") :
                        a("#pData", "#" + o + "_2").removeClass("ui-state-disabled");
                    b === d ? a("#nData", "#" + o + "_2").addClass("ui-state-disabled") : void 0 !== c[1][b + 1] && a("#" + a.jgrid.jqID(c[1][b + 1])).hasClass("ui-state-disabled") ? a("#nData", o + "_2").addClass("ui-state-disabled") : a("#nData", "#" + o + "_2").removeClass("ui-state-disabled")
                }

                function i() {
                    var b = a(j).jqGrid("getDataIDs"),
                        c = a("#id_g", "#" + o).val();
                    return [a.inArray(c, b), b]
                }
                var j = this;
                if (j.grid && e) {
                    var k = j.p.id,
                        m = "ViewGrid_" + a.jgrid.jqID(k),
                        o = "ViewTbl_" + a.jgrid.jqID(k),
                        n = "ViewGrid_" +
                        k,
                        l = "ViewTbl_" + k,
                        p = {
                            themodal: "viewmod" + k,
                            modalhead: "viewhd" + k,
                            modalcontent: "viewcnt" + k,
                            scrollelm: m
                        },
                        r = a.isFunction(d[j.p.id].beforeInitData) ? d[j.p.id].beforeInitData : !1,
                        q = !0,
                        s = 1,
                        t = 0;
                    b.recreateForm || a(j).data("viewProp") && a.extend(d[a(this)[0].p.id], a(j).data("viewProp"));
                    var w = isNaN(d[a(this)[0].p.id].dataheight) ? d[a(this)[0].p.id].dataheight : d[a(this)[0].p.id].dataheight + "px",
                        v = isNaN(d[a(this)[0].p.id].datawidth) ? d[a(this)[0].p.id].datawidth : d[a(this)[0].p.id].datawidth + "px",
                        n = a("<form name='FormPost' id='" +
                            n + "' class='FormGrid' style='width:" + v + ";overflow:auto;position:relative;height:" + w + ";'></form>"),
                        x = a("<table id='" + l + "' class='EditTable' cellspacing='1' cellpadding='2' border='0' style='table-layout:fixed'><tbody></tbody></table>");
                    a(j.p.colModel).each(function() {
                        var a = this.formoptions;
                        s = Math.max(s, a ? a.colpos || 0 : 0);
                        t = Math.max(t, a ? a.rowpos || 0 : 0)
                    });
                    a(n).append(x);
                    r && (q = r.call(j, n), void 0 === q && (q = !0));
                    if (!1 !== q) {
                        c(e, j, x, s);
                        l = "rtl" === j.p.direction ? !0 : !1;
                        r = "<a id='" + (l ? "nData" : "pData") + "' class='fm-button ui-state-default ui-corner-left'><span class='ui-icon ui-icon-triangle-1-w'></span></a>";
                        q = "<a id='" + (l ? "pData" : "nData") + "' class='fm-button ui-state-default ui-corner-right'><span class='ui-icon ui-icon-triangle-1-e'></span></a>";
                        w = "<a id='cData' class='fm-button ui-state-default ui-corner-all'>" + b.bClose + "</a>";
                        if (0 < t) {
                            var H = [];
                            a.each(a(x)[0].rows, function(a, b) {
                                H[a] = b
                            });
                            H.sort(function(a, b) {
                                return a.rp > b.rp ? 1 : a.rp < b.rp ? -1 : 0
                            });
                            a.each(H, function(b, c) {
                                a("tbody", x).append(c)
                            })
                        }
                        b.gbox = "#gbox_" + a.jgrid.jqID(k);
                        n = a("<div></div>").append(n).append("<table border='0' class='EditTable' id='" +
                            o + "_2'><tbody><tr id='Act_Buttons'><td class='navButton' width='" + b.labelswidth + "'>" + (l ? q + r : r + q) + "</td><td class='EditButton'>" + w + "</td></tr></tbody></table>");
                        a.jgrid.createModal(p, n, b, "#gview_" + a.jgrid.jqID(j.p.id), a("#gview_" + a.jgrid.jqID(j.p.id))[0]);
                        l && (a("#pData, #nData", "#" + o + "_2").css("float", "right"), a(".EditButton", "#" + o + "_2").css("text-align", "left"));
                        b.viewPagerButtons || a("#pData, #nData", "#" + o + "_2").hide();
                        n = null;
                        a("#" + p.themodal).keydown(function(c) {
                            if (c.which === 27) {
                                d[j.p.id].closeOnEscape &&
                                    a.jgrid.hideModal("#" + a.jgrid.jqID(p.themodal), {
                                        gb: b.gbox,
                                        jqm: b.jqModal,
                                        onClose: b.onClose
                                    });
                                return false
                            }
                            if (b.navkeys[0] === true) {
                                if (c.which === b.navkeys[1]) {
                                    a("#pData", "#" + o + "_2").trigger("click");
                                    return false
                                }
                                if (c.which === b.navkeys[2]) {
                                    a("#nData", "#" + o + "_2").trigger("click");
                                    return false
                                }
                            }
                        });
                        b.closeicon = a.extend([!0, "left", "ui-icon-close"], b.closeicon);
                        !0 === b.closeicon[0] && a("#cData", "#" + o + "_2").addClass("right" === b.closeicon[1] ? "fm-button-icon-right" : "fm-button-icon-left").append("<span class='ui-icon " +
                            b.closeicon[2] + "'></span>");
                        a.isFunction(b.beforeShowForm) && b.beforeShowForm.call(j, a("#" + m));
                        a.jgrid.viewModal("#" + a.jgrid.jqID(p.themodal), {
                            gbox: "#gbox_" + a.jgrid.jqID(k),
                            jqm: b.jqModal,
                            overlay: b.overlay,
                            modal: b.modal,
                            onHide: function(b) {
                                a(j).data("viewProp", {
                                    top: parseFloat(a(b.w).css("top")),
                                    left: parseFloat(a(b.w).css("left")),
                                    width: a(b.w).width(),
                                    height: a(b.w).height(),
                                    dataheight: a("#" + m).height(),
                                    datawidth: a("#" + m).width()
                                });
                                b.w.remove();
                                b.o && b.o.remove()
                            }
                        });
                        a(".fm-button:not(.ui-state-disabled)",
                            "#" + o + "_2").hover(function() {
                            a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        });
                        f();
                        a("#cData", "#" + o + "_2").click(function() {
                            a.jgrid.hideModal("#" + a.jgrid.jqID(p.themodal), {
                                gb: "#gbox_" + a.jgrid.jqID(k),
                                jqm: b.jqModal,
                                onClose: b.onClose
                            });
                            return false
                        });
                        a("#nData", "#" + o + "_2").click(function() {
                            a("#FormError", "#" + o).hide();
                            var c = i();
                            c[0] = parseInt(c[0], 10);
                            if (c[0] !== -1 && c[1][c[0] + 1]) {
                                a.isFunction(b.onclickPgButtons) && b.onclickPgButtons.call(j, "next", a("#" + m), c[1][c[0]]);
                                h(c[1][c[0] + 1], j);
                                a(j).jqGrid("setSelection", c[1][c[0] + 1]);
                                a.isFunction(b.afterclickPgButtons) && b.afterclickPgButtons.call(j, "next", a("#" + m), c[1][c[0] + 1]);
                                g(c[0] + 1, c)
                            }
                            f();
                            return false
                        });
                        a("#pData", "#" + o + "_2").click(function() {
                            a("#FormError", "#" + o).hide();
                            var c = i();
                            if (c[0] !== -1 && c[1][c[0] - 1]) {
                                a.isFunction(b.onclickPgButtons) && b.onclickPgButtons.call(j, "prev", a("#" + m), c[1][c[0]]);
                                h(c[1][c[0] - 1], j);
                                a(j).jqGrid("setSelection", c[1][c[0] - 1]);
                                a.isFunction(b.afterclickPgButtons) && b.afterclickPgButtons.call(j,
                                    "prev", a("#" + m), c[1][c[0] - 1]);
                                g(c[0] - 1, c)
                            }
                            f();
                            return false
                        });
                        n = i();
                        g(n[0], n)
                    }
                }
            })
        },
        delGridRow: function(e, b) {
            b = a.extend(!0, {
                    top: 0,
                    left: 0,
                    width: 240,
                    height: "auto",
                    dataheight: "auto",
                    modal: !1,
                    overlay: 30,
                    drag: !0,
                    resize: !0,
                    url: "",
                    mtype: "POST",
                    reloadAfterSubmit: !0,
                    beforeShowForm: null,
                    beforeInitData: null,
                    afterShowForm: null,
                    beforeSubmit: null,
                    onclickSubmit: null,
                    afterSubmit: null,
                    jqModal: !0,
                    closeOnEscape: !1,
                    delData: {},
                    delicon: [],
                    cancelicon: [],
                    onClose: null,
                    ajaxDelOptions: {},
                    processing: !1,
                    serializeDelData: null,
                    useDataProxy: !1
                },
                a.jgrid.del, b || {});
            d[a(this)[0].p.id] = b;
            return this.each(function() {
                var f = this;
                if (f.grid && e) {
                    var c = a.isFunction(d[f.p.id].beforeShowForm),
                        h = a.isFunction(d[f.p.id].afterShowForm),
                        g = a.isFunction(d[f.p.id].beforeInitData) ? d[f.p.id].beforeInitData : !1,
                        i = f.p.id,
                        j = {},
                        k = !0,
                        m = "DelTbl_" + a.jgrid.jqID(i),
                        o, n, l, p, r = "DelTbl_" + i,
                        q = {
                            themodal: "delmod" + i,
                            modalhead: "delhd" + i,
                            modalcontent: "delcnt" + i,
                            scrollelm: m
                        };
                    a.isArray(e) && (e = e.join());
                    if (void 0 !== a("#" + a.jgrid.jqID(q.themodal))[0]) {
                        g && (k = g.call(f, a("#" + m)), void 0 ===
                            k && (k = !0));
                        if (!1 === k) return;
                        a("#DelData>td", "#" + m).text(e);
                        a("#DelError", "#" + m).hide();
                        !0 === d[f.p.id].processing && (d[f.p.id].processing = !1, a("#dData", "#" + m).removeClass("ui-state-active"));
                        c && d[f.p.id].beforeShowForm.call(f, a("#" + m));
                        a.jgrid.viewModal("#" + a.jgrid.jqID(q.themodal), {
                            gbox: "#gbox_" + a.jgrid.jqID(i),
                            jqm: d[f.p.id].jqModal,
                            jqM: !1,
                            overlay: d[f.p.id].overlay,
                            modal: d[f.p.id].modal
                        })
                    } else {
                        var s = isNaN(d[f.p.id].dataheight) ? d[f.p.id].dataheight : d[f.p.id].dataheight + "px",
                            t = isNaN(b.datawidth) ? b.datawidth :
                            b.datawidth + "px",
                            r = "<div id='" + r + "' class='formdata' style='width:" + t + ";overflow:auto;position:relative;height:" + s + ";'><table class='DelTable'><tbody><tr id='DelError' style='display:none'><td class='ui-state-error'></td></tr>" + ("<tr id='DelData' style='display:none'><td >" + e + "</td></tr>"),
                            r = r + ('<tr><td class="delmsg" style="white-space:pre;">' + d[f.p.id].msg + "</td></tr><tr><td >&#160;</td></tr>"),
                            r = r + "</tbody></table></div>" + ("<table cellspacing='0' cellpadding='0' border='0' class='EditTable' id='" +
                                m + "_2'><tbody><tr><td><hr class='ui-widget-content' style='margin:1px'/></td></tr><tr><td class='DelButton EditButton'>" + ("<a id='dData' class='fm-button ui-state-default ui-corner-all'>" + b.bSubmit + "</a>") + "&#160;" + ("<a id='eData' class='fm-button ui-state-default ui-corner-all'>" + b.bCancel + "</a>") + "</td></tr></tbody></table>");
                        b.gbox = "#gbox_" + a.jgrid.jqID(i);
                        a.jgrid.createModal(q, r, b, "#gview_" + a.jgrid.jqID(f.p.id), a("#gview_" + a.jgrid.jqID(f.p.id))[0]);
                        g && (k = g.call(f, a(r)), void 0 === k && (k = !0));
                        if (!1 ===
                            k) return;
                        a(".fm-button", "#" + m + "_2").hover(function() {
                            a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        });
                        b.delicon = a.extend([!0, "left", "ui-icon-scissors"], d[f.p.id].delicon);
                        b.cancelicon = a.extend([!0, "left", "ui-icon-cancel"], d[f.p.id].cancelicon);
                        !0 === b.delicon[0] && a("#dData", "#" + m + "_2").addClass("right" === b.delicon[1] ? "fm-button-icon-right" : "fm-button-icon-left").append("<span class='ui-icon " + b.delicon[2] + "'></span>");
                        !0 === b.cancelicon[0] && a("#eData", "#" + m + "_2").addClass("right" ===
                            b.cancelicon[1] ? "fm-button-icon-right" : "fm-button-icon-left").append("<span class='ui-icon " + b.cancelicon[2] + "'></span>");
                        a("#dData", "#" + m + "_2").click(function() {
                            var c = [true, ""],
                                e, g = a("#DelData>td", "#" + m).text();
                            j = {};
                            a.isFunction(d[f.p.id].onclickSubmit) && (j = d[f.p.id].onclickSubmit.call(f, d[f.p.id], g) || {});
                            a.isFunction(d[f.p.id].beforeSubmit) && (c = d[f.p.id].beforeSubmit.call(f, g));
                            if (c[0] && !d[f.p.id].processing) {
                                d[f.p.id].processing = true;
                                l = f.p.prmNames;
                                o = a.extend({}, d[f.p.id].delData, j);
                                p = l.oper;
                                o[p] =
                                    l.deloper;
                                n = l.id;
                                g = ("" + g).split(",");
                                if (!g.length) return false;
                                for (e in g) g.hasOwnProperty(e) && (g[e] = a.jgrid.stripPref(f.p.idPrefix, g[e]));
                                o[n] = g.join();
                                a(this).addClass("ui-state-active");
                                e = a.extend({
                                    url: d[f.p.id].url || a(f).jqGrid("getGridParam", "editurl"),
                                    type: d[f.p.id].mtype,
                                    data: a.isFunction(d[f.p.id].serializeDelData) ? d[f.p.id].serializeDelData.call(f, o) : o,
                                    complete: function(e, h) {
                                        var j;
                                        if (e.status >= 300 && e.status !== 304) {
                                            c[0] = false;
                                            c[1] = a.isFunction(d[f.p.id].errorTextFormat) ? d[f.p.id].errorTextFormat.call(f,
                                                e) : h + " Status: '" + e.statusText + "'. Error code: " + e.status
                                        } else a.isFunction(d[f.p.id].afterSubmit) && (c = d[f.p.id].afterSubmit.call(f, e, o)); if (c[0] === false) {
                                            a("#DelError>td", "#" + m).html(c[1]);
                                            a("#DelError", "#" + m).show()
                                        } else {
                                            if (d[f.p.id].reloadAfterSubmit && f.p.datatype !== "local") a(f).trigger("reloadGrid");
                                            else {
                                                if (f.p.treeGrid === true) try {
                                                    a(f).jqGrid("delTreeNode", f.p.idPrefix + g[0])
                                                } catch (k) {} else
                                                    for (j = 0; j < g.length; j++) a(f).jqGrid("delRowData", f.p.idPrefix + g[j]);
                                                f.p.selrow = null;
                                                f.p.selarrrow = []
                                            }
                                            a.isFunction(d[f.p.id].afterComplete) &&
                                                setTimeout(function() {
                                                    d[f.p.id].afterComplete.call(f, e, g)
                                                }, 500)
                                        }
                                        d[f.p.id].processing = false;
                                        a("#dData", "#" + m + "_2").removeClass("ui-state-active");
                                        c[0] && a.jgrid.hideModal("#" + a.jgrid.jqID(q.themodal), {
                                            gb: "#gbox_" + a.jgrid.jqID(i),
                                            jqm: b.jqModal,
                                            onClose: d[f.p.id].onClose
                                        })
                                    }
                                }, a.jgrid.ajaxOptions, d[f.p.id].ajaxDelOptions);
                                if (!e.url && !d[f.p.id].useDataProxy)
                                    if (a.isFunction(f.p.dataProxy)) d[f.p.id].useDataProxy = true;
                                    else {
                                        c[0] = false;
                                        c[1] = c[1] + (" " + a.jgrid.errors.nourl)
                                    }
                                if (c[0])
                                    if (d[f.p.id].useDataProxy) {
                                        e =
                                            f.p.dataProxy.call(f, e, "del_" + f.p.id);
                                        e === void 0 && (e = [true, ""]);
                                        if (e[0] === false) {
                                            c[0] = false;
                                            c[1] = e[1] || "Error deleting the selected row!"
                                        } else a.jgrid.hideModal("#" + a.jgrid.jqID(q.themodal), {
                                            gb: "#gbox_" + a.jgrid.jqID(i),
                                            jqm: b.jqModal,
                                            onClose: d[f.p.id].onClose
                                        })
                                    } else if (e.url === "clientArray") {
                                    o = e.data;
                                    e.complete({
                                        status: 200,
                                        statusText: ""
                                    }, "")
                                } else a.ajax(e)
                            }
                            if (c[0] === false) {
                                a("#DelError>td", "#" + m).html(c[1]);
                                a("#DelError", "#" + m).show()
                            }
                            return false
                        });
                        a("#eData", "#" + m + "_2").click(function() {
                            a.jgrid.hideModal("#" +
                                a.jgrid.jqID(q.themodal), {
                                    gb: "#gbox_" + a.jgrid.jqID(i),
                                    jqm: d[f.p.id].jqModal,
                                    onClose: d[f.p.id].onClose
                                });
                            return false
                        });
                        c && d[f.p.id].beforeShowForm.call(f, a("#" + m));
                        a.jgrid.viewModal("#" + a.jgrid.jqID(q.themodal), {
                            gbox: "#gbox_" + a.jgrid.jqID(i),
                            jqm: d[f.p.id].jqModal,
                            overlay: d[f.p.id].overlay,
                            modal: d[f.p.id].modal
                        })
                    }
                    h && d[f.p.id].afterShowForm.call(f, a("#" + m));
                    !0 === d[f.p.id].closeOnEscape && setTimeout(function() {
                            a(".ui-jqdialog-titlebar-close", "#" + a.jgrid.jqID(q.modalhead)).attr("tabindex", "-1").focus()
                        },
                        0)
                }
            })
        },
        navGrid: function(d, b, f, c, h, g, i) {
            b = a.extend({
                edit: !0,
                editicon: "ui-icon-pencil",
                add: !0,
                addicon: "ui-icon-plus",
                del: !0,
                delicon: "ui-icon-trash",
                search: !0,
                searchicon: "ui-icon-search",
                refresh: !0,
                refreshicon: "ui-icon-refresh",
                refreshstate: "firstpage",
                view: !1,
                viewicon: "ui-icon-document",
                position: "left",
                closeOnEscape: !0,
                beforeRefresh: null,
                afterRefresh: null,
                cloneToTop: !1,
                alertwidth: 200,
                alertheight: "auto",
                alerttop: null,
                alertleft: null,
                alertzIndex: null
            }, a.jgrid.nav, b || {});
            return this.each(function() {
                if (!this.nav) {
                    var j = {
                            themodal: "alertmod_" + this.p.id,
                            modalhead: "alerthd_" + this.p.id,
                            modalcontent: "alertcnt_" + this.p.id
                        },
                        k = this,
                        m;
                    if (k.grid && "string" === typeof d) {
                        void 0 === a("#" + j.themodal)[0] && (!b.alerttop && !b.alertleft && (void 0 !== window.innerWidth ? (b.alertleft = window.innerWidth, b.alerttop = window.innerHeight) : void 0 !== document.documentElement && void 0 !== document.documentElement.clientWidth && 0 !== document.documentElement.clientWidth ? (b.alertleft = document.documentElement.clientWidth, b.alerttop = document.documentElement.clientHeight) :
                            (b.alertleft = 1024, b.alerttop = 768), b.alertleft = b.alertleft / 2 - parseInt(b.alertwidth, 10) / 2, b.alerttop = b.alerttop / 2 - 25), a.jgrid.createModal(j, "<div>" + b.alerttext + "</div><span tabindex='0'><span tabindex='-1' id='jqg_alrt'></span></span>", {
                            gbox: "#gbox_" + a.jgrid.jqID(k.p.id),
                            jqModal: !0,
                            drag: !0,
                            resize: !0,
                            caption: b.alertcap,
                            top: b.alerttop,
                            left: b.alertleft,
                            width: b.alertwidth,
                            height: b.alertheight,
                            closeOnEscape: b.closeOnEscape,
                            zIndex: b.alertzIndex
                        }, "#gview_" + a.jgrid.jqID(k.p.id), a("#gbox_" + a.jgrid.jqID(k.p.id))[0], !0));
                        var o = 1,
                            n, l = function() {
                                a(this).hasClass("ui-state-disabled") || a(this).addClass("ui-state-hover")
                            },
                            p = function() {
                                a(this).removeClass("ui-state-hover")
                            };
                        b.cloneToTop && k.p.toppager && (o = 2);
                        for (n = 0; n < o; n++) {
                            var r = a("<table cellspacing='0' cellpadding='0' border='0' class='ui-pg-table navtable' style='float:left;table-layout:auto;'><tbody><tr></tr></tbody></table>"),
                                q, s;
                            0 === n ? (q = d, s = k.p.id, q === k.p.toppager && (s += "_top", o = 1)) : (q = k.p.toppager, s = k.p.id + "_top");
                            "rtl" === k.p.direction && a(r).attr("dir", "rtl").css("float",
                                "right");
                            b.add && (c = c || {}, m = a("<td class='ui-pg-button ui-corner-all'></td>"), a(m).append("<div class='ui-pg-div'><span class='ui-icon " + b.addicon + "'></span>" + b.addtext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.addtitle || "",
                                id: c.id || "add_" + s
                            }).click(function() {
                                a(this).hasClass("ui-state-disabled") || (a.isFunction(b.addfunc) ? b.addfunc.call(k) : a(k).jqGrid("editGridRow", "new", c));
                                return false
                            }).hover(l, p), m = null);
                            b.edit && (m = a("<td class='ui-pg-button ui-corner-all'></td>"), f = f || {}, a(m).append("<div class='ui-pg-div'><span class='ui-icon " +
                                b.editicon + "'></span>" + b.edittext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.edittitle || "",
                                id: f.id || "edit_" + s
                            }).click(function() {
                                if (!a(this).hasClass("ui-state-disabled")) {
                                    var c = k.p.selrow;
                                    if (c) a.isFunction(b.editfunc) ? b.editfunc.call(k, c) : a(k).jqGrid("editGridRow", c, f);
                                    else {
                                        a.jgrid.viewModal("#" + j.themodal, {
                                            gbox: "#gbox_" + a.jgrid.jqID(k.p.id),
                                            jqm: true
                                        });
                                        a("#jqg_alrt").focus()
                                    }
                                }
                                return false
                            }).hover(l, p), m = null);
                            b.view && (m = a("<td class='ui-pg-button ui-corner-all'></td>"), i = i || {}, a(m).append("<div class='ui-pg-div'><span class='ui-icon " +
                                b.viewicon + "'></span>" + b.viewtext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.viewtitle || "",
                                id: i.id || "view_" + s
                            }).click(function() {
                                if (!a(this).hasClass("ui-state-disabled")) {
                                    var c = k.p.selrow;
                                    if (c) a.isFunction(b.viewfunc) ? b.viewfunc.call(k, c) : a(k).jqGrid("viewGridRow", c, i);
                                    else {
                                        a.jgrid.viewModal("#" + j.themodal, {
                                            gbox: "#gbox_" + a.jgrid.jqID(k.p.id),
                                            jqm: true
                                        });
                                        a("#jqg_alrt").focus()
                                    }
                                }
                                return false
                            }).hover(l, p), m = null);
                            b.del && (m = a("<td class='ui-pg-button ui-corner-all'></td>"), h = h || {}, a(m).append("<div class='ui-pg-div'><span class='ui-icon " +
                                b.delicon + "'></span>" + b.deltext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.deltitle || "",
                                id: h.id || "del_" + s
                            }).click(function() {
                                if (!a(this).hasClass("ui-state-disabled")) {
                                    var c;
                                    if (k.p.multiselect) {
                                        c = k.p.selarrrow;
                                        c.length === 0 && (c = null)
                                    } else c = k.p.selrow; if (c) a.isFunction(b.delfunc) ? b.delfunc.call(k, c) : a(k).jqGrid("delGridRow", c, h);
                                    else {
                                        a.jgrid.viewModal("#" + j.themodal, {
                                            gbox: "#gbox_" + a.jgrid.jqID(k.p.id),
                                            jqm: true
                                        });
                                        a("#jqg_alrt").focus()
                                    }
                                }
                                return false
                            }).hover(l, p), m = null);
                            (b.add || b.edit || b.del ||
                                b.view) && a("tr", r).append("<td class='ui-pg-button ui-state-disabled' style='width:4px;'><span class='ui-separator'></span></td>");
                            b.search && (m = a("<td class='ui-pg-button ui-corner-all'></td>"), g = g || {}, a(m).append("<div class='ui-pg-div'><span class='ui-icon " + b.searchicon + "'></span>" + b.searchtext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.searchtitle || "",
                                id: g.id || "search_" + s
                            }).click(function() {
                                a(this).hasClass("ui-state-disabled") || (a.isFunction(b.searchfunc) ? b.searchfunc.call(k, g) : a(k).jqGrid("searchGrid",
                                    g));
                                return false
                            }).hover(l, p), g.showOnLoad && !0 === g.showOnLoad && a(m, r).click(), m = null);
                            b.refresh && (m = a("<td class='ui-pg-button ui-corner-all'></td>"), a(m).append("<div class='ui-pg-div'><span class='ui-icon " + b.refreshicon + "'></span>" + b.refreshtext + "</div>"), a("tr", r).append(m), a(m, r).attr({
                                title: b.refreshtitle || "",
                                id: "refresh_" + s
                            }).click(function() {
                                if (!a(this).hasClass("ui-state-disabled")) {
                                    a.isFunction(b.beforeRefresh) && b.beforeRefresh.call(k);
                                    k.p.search = false;
                                    k.p.resetsearch = true;
                                    try {
                                        if (b.refreshstate !==
                                            "currentfilter") {
                                            var c = k.p.id;
                                            k.p.postData.filters = "";
                                            try {
                                                a("#fbox_" + a.jgrid.jqID(c)).jqFilter("resetFilter")
                                            } catch (d) {}
                                            a.isFunction(k.clearToolbar) && k.clearToolbar.call(k, false)
                                        }
                                    } catch (e) {}
                                    switch (b.refreshstate) {
                                        case "firstpage":
                                            a(k).trigger("reloadGrid", [{
                                                page: 1
                                            }]);
                                            break;
                                        case "current":
                                        case "currentfilter":
                                            a(k).trigger("reloadGrid", [{
                                                current: true
                                            }])
                                    }
                                    a.isFunction(b.afterRefresh) && b.afterRefresh.call(k)
                                }
                                return false
                            }).hover(l, p), m = null);
                            m = a(".ui-jqgrid").css("font-size") || "11px";
                            a("body").append("<div id='testpg2' class='ui-jqgrid ui-widget ui-widget-content' style='font-size:" +
                                m + ";visibility:hidden;' ></div>");
                            m = a(r).clone().appendTo("#testpg2").width();
                            a("#testpg2").remove();
                            a(q + "_" + b.position, q).append(r);
                            k.p._nvtd && (m > k.p._nvtd[0] && (a(q + "_" + b.position, q).width(m), k.p._nvtd[0] = m), k.p._nvtd[1] = m);
                            r = m = m = null;
                            this.nav = !0
                        }
                    }
                }
            })
        },
        navButtonAdd: function(d, b) {
            b = a.extend({
                caption: "newButton",
                title: "",
                buttonicon: "ui-icon-newwin",
                onClickButton: null,
                position: "last",
                cursor: "pointer"
            }, b || {});
            return this.each(function() {
                if (this.grid) {
                    "string" === typeof d && 0 !== d.indexOf("#") && (d = "#" + a.jgrid.jqID(d));
                    var f = a(".navtable", d)[0],
                        c = this;
                    if (f && !(b.id && void 0 !== a("#" + a.jgrid.jqID(b.id), f)[0])) {
                        var h = a("<td></td>");
                        "NONE" === b.buttonicon.toString().toUpperCase() ? a(h).addClass("ui-pg-button ui-corner-all").append("<div class='ui-pg-div'>" + b.caption + "</div>") : a(h).addClass("ui-pg-button ui-corner-all").append("<div class='ui-pg-div'><span class='ui-icon " + b.buttonicon + "'></span>" + b.caption + "</div>");
                        b.id && a(h).attr("id", b.id);
                        "first" === b.position ? 0 === f.rows[0].cells.length ? a("tr", f).append(h) : a("tr td:eq(0)",
                            f).before(h) : a("tr", f).append(h);
                        a(h, f).attr("title", b.title || "").click(function(d) {
                            a(this).hasClass("ui-state-disabled") || a.isFunction(b.onClickButton) && b.onClickButton.call(c, d);
                            return !1
                        }).hover(function() {
                            a(this).hasClass("ui-state-disabled") || a(this).addClass("ui-state-hover")
                        }, function() {
                            a(this).removeClass("ui-state-hover")
                        })
                    }
                }
            })
        },
        navSeparatorAdd: function(d, b) {
            b = a.extend({
                sepclass: "ui-separator",
                sepcontent: "",
                position: "last"
            }, b || {});
            return this.each(function() {
                if (this.grid) {
                    "string" === typeof d &&
                        0 !== d.indexOf("#") && (d = "#" + a.jgrid.jqID(d));
                    var f = a(".navtable", d)[0];
                    if (f) {
                        var c = "<td class='ui-pg-button ui-state-disabled' style='width:4px;'><span class='" + b.sepclass + "'></span>" + b.sepcontent + "</td>";
                        "first" === b.position ? 0 === f.rows[0].cells.length ? a("tr", f).append(c) : a("tr td:eq(0)", f).before(c) : a("tr", f).append(c)
                    }
                }
            })
        },
        GridToForm: function(d, b) {
            return this.each(function() {
                var f = this,
                    c;
                if (f.grid) {
                    var h = a(f).jqGrid("getRowData", d);
                    if (h)
                        for (c in h) h.hasOwnProperty(c) && (a("[name=" + a.jgrid.jqID(c) +
                            "]", b).is("input:radio") || a("[name=" + a.jgrid.jqID(c) + "]", b).is("input:checkbox") ? a("[name=" + a.jgrid.jqID(c) + "]", b).each(function() {
                            if (a(this).val() == h[c]) a(this)[f.p.useProp ? "prop" : "attr"]("checked", !0);
                            else a(this)[f.p.useProp ? "prop" : "attr"]("checked", !1)
                        }) : a("[name=" + a.jgrid.jqID(c) + "]", b).val(h[c]))
                }
            })
        },
        FormToGrid: function(d, b, f, c) {
            return this.each(function() {
                if (this.grid) {
                    f || (f = "set");
                    c || (c = "first");
                    var h = a(b).serializeArray(),
                        g = {};
                    a.each(h, function(a, b) {
                        g[b.name] = b.value
                    });
                    "add" === f ? a(this).jqGrid("addRowData",
                        d, g, c) : "set" === f && a(this).jqGrid("setRowData", d, g)
                }
            })
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.inlineEdit = a.jgrid.inlineEdit || {};
    a.jgrid.extend({
        editRow: function(d, e, b, f, c, h, g, i, j) {
            var k = {},
                m = a.makeArray(arguments).slice(1);
            if ("object" === a.type(m[0])) k = m[0];
            else if (void 0 !== e && (k.keys = e), a.isFunction(b) && (k.oneditfunc = b), a.isFunction(f) && (k.successfunc = f), void 0 !== c && (k.url = c), void 0 !== h && (k.extraparam = h), a.isFunction(g) && (k.aftersavefunc = g), a.isFunction(i) && (k.errorfunc = i), a.isFunction(j)) k.afterrestorefunc = j;
            k = a.extend(!0, {
                keys: !1,
                oneditfunc: null,
                successfunc: null,
                url: null,
                extraparam: {},
                aftersavefunc: null,
                errorfunc: null,
                afterrestorefunc: null,
                restoreAfterError: !0,
                mtype: "POST",
                focusField: !0
            }, a.jgrid.inlineEdit, k);
            return this.each(function() {
                var b = this,
                    c, e, f, g = 0,
                    i = null,
                    h = {},
                    j, m;
                b.grid && (j = a(b).jqGrid("getInd", d, !0), !1 !== j && (f = a.isFunction(k.beforeEditRow) ? k.beforeEditRow.call(b, k, d) : void 0, void 0 === f && (f = !0), f && (f = a(j).attr("editable") || "0", "0" === f && !a(j).hasClass("not-editable-row") && (m = b.p.colModel, a('td[role="gridcell"]', j).each(function(f) {
                    c = m[f].name;
                    var j = !0 === b.p.treeGrid &&
                        c === b.p.ExpandColumn;
                    if (j) e = a("span:first", this).html();
                    else try {
                        e = a.unformat.call(b, this, {
                            rowId: d,
                            colModel: m[f]
                        }, f)
                    } catch (k) {
                        e = m[f].edittype && "textarea" === m[f].edittype ? a(this).text() : a(this).html()
                    }
                    if ("cb" !== c && ("subgrid" !== c && "rn" !== c) && (b.p.autoencode && (e = a.jgrid.htmlDecode(e)), h[c] = e, !0 === m[f].editable)) {
                        null === i && (i = f);
                        j ? a("span:first", this).html("") : a(this).html("");
                        var p = a.extend({}, m[f].editoptions || {}, {
                            id: d + "_" + c,
                            name: c,
                            rowId: d
                        });
                        m[f].edittype || (m[f].edittype = "text");
                        if ("&nbsp;" === e || "&#160;" ===
                            e || 1 === e.length && 160 === e.charCodeAt(0)) e = "";
                        var t = a.jgrid.createEl.call(b, m[f].edittype, p, e, !0, a.extend({}, a.jgrid.ajaxOptions, b.p.ajaxSelectOptions || {}));
                        a(t).addClass("editable");
                        j ? a("span:first", this).append(t) : a(this).append(t);
                        a.jgrid.bindEv.call(b, t, p);
                        "select" === m[f].edittype && (void 0 !== m[f].editoptions && !0 === m[f].editoptions.multiple && void 0 === m[f].editoptions.dataUrl && a.jgrid.msie) && a(t).width(a(t).width());
                        g++
                    }
                }), 0 < g && (h.id = d, b.p.savedRow.push(h), a(j).attr("editable", "1"), k.focusField &&
                    ("number" === typeof k.focusField && parseInt(k.focusField, 10) <= m.length && (i = k.focusField), setTimeout(function() {
                        var b = a("td:eq(" + i + ") :input:visible", j).not(":disabled");
                        b.length > 0 && b.focus()
                    }, 0)), !0 === k.keys && a(j).bind("keydown", function(c) {
                        if (c.keyCode === 27) {
                            a(b).jqGrid("restoreRow", d, k.afterrestorefunc);
                            if (b.p._inlinenav) try {
                                a(b).jqGrid("showAddEditButtons")
                            } catch (e) {}
                            return false
                        }
                        if (c.keyCode === 13) {
                            if (c.target.tagName === "TEXTAREA") return true;
                            if (a(b).jqGrid("saveRow", d, k) && b.p._inlinenav) try {
                                a(b).jqGrid("showAddEditButtons")
                            } catch (f) {}
                            return false
                        }
                    }),
                    a(b).triggerHandler("jqGridInlineEditRow", [d, k]), a.isFunction(k.oneditfunc) && k.oneditfunc.call(b, d))))))
            })
        },
        saveRow: function(d, e, b, f, c, h, g) {
            var i = a.makeArray(arguments).slice(1),
                j = {};
            if ("object" === a.type(i[0])) j = i[0];
            else if (a.isFunction(e) && (j.successfunc = e), void 0 !== b && (j.url = b), void 0 !== f && (j.extraparam = f), a.isFunction(c) && (j.aftersavefunc = c), a.isFunction(h) && (j.errorfunc = h), a.isFunction(g)) j.afterrestorefunc = g;
            var j = a.extend(!0, {
                    successfunc: null,
                    url: null,
                    extraparam: {},
                    aftersavefunc: null,
                    errorfunc: null,
                    afterrestorefunc: null,
                    restoreAfterError: !0,
                    mtype: "POST"
                }, a.jgrid.inlineEdit, j),
                k = !1,
                m = this[0],
                o, n = {},
                l = {},
                p = {},
                r, q, s;
            if (!m.grid) return k;
            s = a(m).jqGrid("getInd", d, !0);
            if (!1 === s) return k;
            i = a.isFunction(j.beforeSaveRow) ? j.beforeSaveRow.call(m, j, d) : void 0;
            void 0 === i && (i = !0);
            if (i) {
                i = a(s).attr("editable");
                j.url = j.url || m.p.editurl;
                if ("1" === i) {
                    var t;
                    a('td[role="gridcell"]', s).each(function(b) {
                        t = m.p.colModel[b];
                        o = t.name;
                        if ("cb" !== o && "subgrid" !== o && !0 === t.editable && "rn" !== o && !a(this).hasClass("not-editable-cell")) {
                            switch (t.edittype) {
                                case "checkbox":
                                    var c = ["Yes", "No"];
                                    t.editoptions && (c = t.editoptions.value.split(":"));
                                    n[o] = a("input", this).is(":checked") ? c[0] : c[1];
                                    break;
                                case "text":
                                case "password":
                                case "textarea":
                                case "button":
                                    n[o] = a("input, textarea", this).val();
                                    break;
                                case "select":
                                    if (t.editoptions.multiple) {
                                        var c = a("select", this),
                                            d = [];
                                        n[o] = a(c).val();
                                        n[o] = n[o] ? n[o].join(",") : "";
                                        a("select option:selected", this).each(function(b, c) {
                                            d[b] = a(c).text()
                                        });
                                        l[o] = d.join(",")
                                    } else n[o] = a("select option:selected", this).val(), l[o] = a("select option:selected", this).text();
                                    t.formatter && "select" === t.formatter && (l = {});
                                    break;
                                case "custom":
                                    try {
                                        if (t.editoptions && a.isFunction(t.editoptions.custom_value)) {
                                            if (n[o] = t.editoptions.custom_value.call(m, a(".customelement", this), "get"), void 0 === n[o]) throw "e2";
                                        } else throw "e1";
                                    } catch (e) {
                                        "e1" === e && a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.nodefined, a.jgrid.edit.bClose), "e2" === e ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.novalue, a.jgrid.edit.bClose) :
                                            a.jgrid.info_dialog(a.jgrid.errors.errcap, e.message, a.jgrid.edit.bClose)
                                    }
                            }
                            q = a.jgrid.checkValues.call(m, n[o], b);
                            if (!1 === q[0]) return !1;
                            m.p.autoencode && (n[o] = a.jgrid.htmlEncode(n[o]));
                            "clientArray" !== j.url && t.editoptions && !0 === t.editoptions.NullIfEmpty && "" === n[o] && (p[o] = "null")
                        }
                    });
                    if (!1 === q[0]) {
                        try {
                            var w = a(m).jqGrid("getGridRowById", d),
                                v = a.jgrid.findPos(w);
                            a.jgrid.info_dialog(a.jgrid.errors.errcap, q[1], a.jgrid.edit.bClose, {
                                left: v[0],
                                top: v[1] + a(w).outerHeight()
                            })
                        } catch (x) {
                            alert(q[1])
                        }
                        return k
                    }
                    i = m.p.prmNames;
                    w = d;
                    v = !1 === m.p.keyName ? i.id : m.p.keyName;
                    if (n) {
                        n[i.oper] = i.editoper;
                        if (void 0 === n[v] || "" === n[v]) n[v] = d;
                        else if (s.id !== m.p.idPrefix + n[v] && (i = a.jgrid.stripPref(m.p.idPrefix, d), void 0 !== m.p._index[i] && (m.p._index[n[v]] = m.p._index[i], delete m.p._index[i]), d = m.p.idPrefix + n[v], a(s).attr("id", d), m.p.selrow === w && (m.p.selrow = d), a.isArray(m.p.selarrrow) && (i = a.inArray(w, m.p.selarrrow), 0 <= i && (m.p.selarrrow[i] = d)), m.p.multiselect)) i = "jqg_" + m.p.id + "_" + d, a("input.cbox", s).attr("id", i).attr("name", i);
                        void 0 === m.p.inlineData &&
                            (m.p.inlineData = {});
                        n = a.extend({}, n, m.p.inlineData, j.extraparam)
                    }
                    if ("clientArray" === j.url) {
                        n = a.extend({}, n, l);
                        m.p.autoencode && a.each(n, function(b, c) {
                            n[b] = a.jgrid.htmlDecode(c)
                        });
                        i = a(m).jqGrid("setRowData", d, n);
                        a(s).attr("editable", "0");
                        for (v = 0; v < m.p.savedRow.length; v++)
                            if ("" + m.p.savedRow[v].id === "" + w) {
                                r = v;
                                break
                            }
                        0 <= r && m.p.savedRow.splice(r, 1);
                        a(m).triggerHandler("jqGridInlineAfterSaveRow", [d, i, n, j]);
                        a.isFunction(j.aftersavefunc) && j.aftersavefunc.call(m, d, i, n, j);
                        k = !0;
                        a(s).removeClass("jqgrid-new-row").unbind("keydown")
                    } else a("#lui_" +
                        a.jgrid.jqID(m.p.id)).show(), p = a.extend({}, n, p), p[v] = a.jgrid.stripPref(m.p.idPrefix, p[v]), a.ajax(a.extend({
                        url: j.url,
                        data: a.isFunction(m.p.serializeRowData) ? m.p.serializeRowData.call(m, p) : p,
                        type: j.mtype,
                        async: !1,
                        complete: function(b, c) {
                            a("#lui_" + a.jgrid.jqID(m.p.id)).hide();
                            if ("success" === c) {
                                var e = !0,
                                    f;
                                f = a(m).triggerHandler("jqGridInlineSuccessSaveRow", [b, d, j]);
                                a.isArray(f) || (f = [!0, n]);
                                f[0] && a.isFunction(j.successfunc) && (f = j.successfunc.call(m, b));
                                a.isArray(f) ? (e = f[0], n = f[1] || n) : e = f;
                                if (!0 === e) {
                                    m.p.autoencode &&
                                        a.each(n, function(b, c) {
                                            n[b] = a.jgrid.htmlDecode(c)
                                        });
                                    n = a.extend({}, n, l);
                                    a(m).jqGrid("setRowData", d, n);
                                    a(s).attr("editable", "0");
                                    for (e = 0; e < m.p.savedRow.length; e++)
                                        if ("" + m.p.savedRow[e].id === "" + d) {
                                            r = e;
                                            break
                                        }
                                    0 <= r && m.p.savedRow.splice(r, 1);
                                    a(m).triggerHandler("jqGridInlineAfterSaveRow", [d, b, n, j]);
                                    a.isFunction(j.aftersavefunc) && j.aftersavefunc.call(m, d, b, n, j);
                                    k = !0;
                                    a(s).removeClass("jqgrid-new-row").unbind("keydown")
                                } else a(m).triggerHandler("jqGridInlineErrorSaveRow", [d, b, c, null, j]), a.isFunction(j.errorfunc) &&
                                    j.errorfunc.call(m, d, b, c, null), !0 === j.restoreAfterError && a(m).jqGrid("restoreRow", d, j.afterrestorefunc)
                            }
                        },
                        error: function(b, c, e) {
                            a("#lui_" + a.jgrid.jqID(m.p.id)).hide();
                            a(m).triggerHandler("jqGridInlineErrorSaveRow", [d, b, c, e, j]);
                            if (a.isFunction(j.errorfunc)) j.errorfunc.call(m, d, b, c, e);
                            else {
                                b = b.responseText || b.statusText;
                                try {
                                    a.jgrid.info_dialog(a.jgrid.errors.errcap, '<div class="ui-state-error">' + b + "</div>", a.jgrid.edit.bClose, {
                                        buttonalign: "right"
                                    })
                                } catch (f) {
                                    alert(b)
                                }
                            }!0 === j.restoreAfterError && a(m).jqGrid("restoreRow",
                                d, j.afterrestorefunc)
                        }
                    }, a.jgrid.ajaxOptions, m.p.ajaxRowOptions || {}))
                }
                return k
            }
        },
        restoreRow: function(d, e) {
            var b = a.makeArray(arguments).slice(1),
                f = {};
            "object" === a.type(b[0]) ? f = b[0] : a.isFunction(e) && (f.afterrestorefunc = e);
            f = a.extend(!0, {}, a.jgrid.inlineEdit, f);
            return this.each(function() {
                var b = this,
                    e = -1,
                    g, i = {},
                    j;
                if (b.grid) {
                    g = a(b).jqGrid("getInd", d, true);
                    if (g !== false) {
                        j = a.isFunction(f.beforeCancelRow) ? f.beforeCancelRow.call(b, f, sr) : void 0;
                        j === void 0 && (j = true);
                        if (j) {
                            for (j = 0; j < b.p.savedRow.length; j++)
                                if ("" +
                                    b.p.savedRow[j].id === "" + d) {
                                    e = j;
                                    break
                                }
                            if (e >= 0) {
                                if (a.isFunction(a.fn.datepicker)) try {
                                    a("input.hasDatepicker", "#" + a.jgrid.jqID(g.id)).datepicker("hide")
                                } catch (k) {}
                                a.each(b.p.colModel, function() {
                                    this.editable === true && b.p.savedRow[e].hasOwnProperty(this.name) && (i[this.name] = b.p.savedRow[e][this.name])
                                });
                                a(b).jqGrid("setRowData", d, i);
                                a(g).attr("editable", "0").unbind("keydown");
                                b.p.savedRow.splice(e, 1);
                                a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(b.p.id)).hasClass("jqgrid-new-row") && setTimeout(function() {
                                    a(b).jqGrid("delRowData",
                                        d);
                                    a(b).jqGrid("showAddEditButtons")
                                }, 0)
                            }
                            a(b).triggerHandler("jqGridInlineAfterRestoreRow", [d]);
                            a.isFunction(f.afterrestorefunc) && f.afterrestorefunc.call(b, d)
                        }
                    }
                }
            })
        },
        addRow: function(d) {
            d = a.extend(!0, {
                rowID: null,
                initdata: {},
                position: "first",
                useDefValues: !0,
                useFormatter: !1,
                addRowParams: {
                    extraparam: {}
                }
            }, d || {});
            return this.each(function() {
                if (this.grid) {
                    var e = this,
                        b = a.isFunction(d.beforeAddRow) ? d.beforeAddRow.call(e, d.addRowParams) : void 0;
                    void 0 === b && (b = !0);
                    b && (d.rowID = a.isFunction(d.rowID) ? d.rowID.call(e,
                            d) : null != d.rowID ? d.rowID : a.jgrid.randId(), !0 === d.useDefValues && a(e.p.colModel).each(function() {
                            if (this.editoptions && this.editoptions.defaultValue) {
                                var b = this.editoptions.defaultValue,
                                    b = a.isFunction(b) ? b.call(e) : b;
                                d.initdata[this.name] = b
                            }
                        }), a(e).jqGrid("addRowData", d.rowID, d.initdata, d.position), d.rowID = e.p.idPrefix + d.rowID, a("#" + a.jgrid.jqID(d.rowID), "#" + a.jgrid.jqID(e.p.id)).addClass("jqgrid-new-row"), d.useFormatter ? a("#" + a.jgrid.jqID(d.rowID) + " .ui-inline-edit", "#" + a.jgrid.jqID(e.p.id)).click() :
                        (b = e.p.prmNames, d.addRowParams.extraparam[b.oper] = b.addoper, a(e).jqGrid("editRow", d.rowID, d.addRowParams), a(e).jqGrid("setSelection", d.rowID)))
                }
            })
        },
        inlineNav: function(d, e) {
            e = a.extend(!0, {
                edit: !0,
                editicon: "ui-icon-pencil",
                add: !0,
                addicon: "ui-icon-plus",
                save: !0,
                saveicon: "ui-icon-disk",
                cancel: !0,
                cancelicon: "ui-icon-cancel",
                addParams: {
                    addRowParams: {
                        extraparam: {}
                    }
                },
                editParams: {},
                restoreAfterSelect: !0
            }, a.jgrid.nav, e || {});
            return this.each(function() {
                if (this.grid) {
                    var b = this,
                        f, c = a.jgrid.jqID(b.p.id);
                    b.p._inlinenav = !0;
                    if (!0 === e.addParams.useFormatter) {
                        var h = b.p.colModel,
                            g;
                        for (g = 0; g < h.length; g++)
                            if (h[g].formatter && "actions" === h[g].formatter) {
                                h[g].formatoptions && (h = a.extend({
                                    keys: !1,
                                    onEdit: null,
                                    onSuccess: null,
                                    afterSave: null,
                                    onError: null,
                                    afterRestore: null,
                                    extraparam: {},
                                    url: null
                                }, h[g].formatoptions), e.addParams.addRowParams = {
                                    keys: h.keys,
                                    oneditfunc: h.onEdit,
                                    successfunc: h.onSuccess,
                                    url: h.url,
                                    extraparam: h.extraparam,
                                    aftersavefunc: h.afterSave,
                                    errorfunc: h.onError,
                                    afterrestorefunc: h.afterRestore
                                });
                                break
                            }
                    }
                    e.add && a(b).jqGrid("navButtonAdd",
                        d, {
                            caption: e.addtext,
                            title: e.addtitle,
                            buttonicon: e.addicon,
                            id: b.p.id + "_iladd",
                            onClickButton: function() {
                                a(b).jqGrid("addRow", e.addParams);
                                e.addParams.useFormatter || (a("#" + c + "_ilsave").removeClass("ui-state-disabled"), a("#" + c + "_ilcancel").removeClass("ui-state-disabled"), a("#" + c + "_iladd").addClass("ui-state-disabled"), a("#" + c + "_iledit").addClass("ui-state-disabled"))
                            }
                        });
                    e.edit && a(b).jqGrid("navButtonAdd", d, {
                        caption: e.edittext,
                        title: e.edittitle,
                        buttonicon: e.editicon,
                        id: b.p.id + "_iledit",
                        onClickButton: function() {
                            var d =
                                a(b).jqGrid("getGridParam", "selrow");
                            d ? (a(b).jqGrid("editRow", d, e.editParams), a("#" + c + "_ilsave").removeClass("ui-state-disabled"), a("#" + c + "_ilcancel").removeClass("ui-state-disabled"), a("#" + c + "_iladd").addClass("ui-state-disabled"), a("#" + c + "_iledit").addClass("ui-state-disabled")) : (a.jgrid.viewModal("#alertmod", {
                                gbox: "#gbox_" + c,
                                jqm: !0
                            }), a("#jqg_alrt").focus())
                        }
                    });
                    e.save && (a(b).jqGrid("navButtonAdd", d, {
                        caption: e.savetext || "",
                        title: e.savetitle || "Save row",
                        buttonicon: e.saveicon,
                        id: b.p.id + "_ilsave",
                        onClickButton: function() {
                            var d =
                                b.p.savedRow[0].id;
                            if (d) {
                                var f = b.p.prmNames,
                                    g = f.oper,
                                    h = e.editParams;
                                a("#" + a.jgrid.jqID(d), "#" + c).hasClass("jqgrid-new-row") ? (e.addParams.addRowParams.extraparam[g] = f.addoper, h = e.addParams.addRowParams) : (e.editParams.extraparam || (e.editParams.extraparam = {}), e.editParams.extraparam[g] = f.editoper);
                                a(b).jqGrid("saveRow", d, h) && a(b).jqGrid("showAddEditButtons")
                            } else a.jgrid.viewModal("#alertmod", {
                                gbox: "#gbox_" + c,
                                jqm: !0
                            }), a("#jqg_alrt").focus()
                        }
                    }), a("#" + c + "_ilsave").addClass("ui-state-disabled"));
                    e.cancel &&
                        (a(b).jqGrid("navButtonAdd", d, {
                            caption: e.canceltext || "",
                            title: e.canceltitle || "Cancel row editing",
                            buttonicon: e.cancelicon,
                            id: b.p.id + "_ilcancel",
                            onClickButton: function() {
                                var d = b.p.savedRow[0].id,
                                    f = e.editParams;
                                if (d) {
                                    if (a("#" + a.jgrid.jqID(d), "#" + c).hasClass("jqgrid-new-row")) f = e.addParams.addRowParams;
                                    a(b).jqGrid("restoreRow", d, f);
                                    a(b).jqGrid("showAddEditButtons")
                                } else {
                                    a.jgrid.viewModal("#alertmod", {
                                        gbox: "#gbox_" + c,
                                        jqm: true
                                    });
                                    a("#jqg_alrt").focus()
                                }
                            }
                        }), a("#" + c + "_ilcancel").addClass("ui-state-disabled"));
                    !0 === e.restoreAfterSelect && (f = a.isFunction(b.p.beforeSelectRow) ? b.p.beforeSelectRow : !1, b.p.beforeSelectRow = function(c, d) {
                        var g = true;
                        if (b.p.savedRow.length > 0 && b.p._inlinenav === true && c !== b.p.selrow && b.p.selrow !== null) {
                            b.p.selrow === e.addParams.rowID ? a(b).jqGrid("delRowData", b.p.selrow) : a(b).jqGrid("restoreRow", b.p.selrow, e.editParams);
                            a(b).jqGrid("showAddEditButtons")
                        }
                        f && (g = f.call(b, c, d));
                        return g
                    })
                }
            })
        },
        showAddEditButtons: function() {
            return this.each(function() {
                if (this.grid) {
                    var d = a.jgrid.jqID(this.p.id);
                    a("#" + d + "_ilsave").addClass("ui-state-disabled");
                    a("#" + d + "_ilcancel").addClass("ui-state-disabled");
                    a("#" + d + "_iladd").removeClass("ui-state-disabled");
                    a("#" + d + "_iledit").removeClass("ui-state-disabled")
                }
            })
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.extend({
        editCell: function(d, e, b) {
            return this.each(function() {
                var f = this,
                    c, h, g, i;
                if (f.grid && !0 === f.p.cellEdit) {
                    e = parseInt(e, 10);
                    f.p.selrow = f.rows[d].id;
                    f.p.knv || a(f).jqGrid("GridNav");
                    if (0 < f.p.savedRow.length) {
                        if (!0 === b && d == f.p.iRow && e == f.p.iCol) return;
                        a(f).jqGrid("saveCell", f.p.savedRow[0].id, f.p.savedRow[0].ic)
                    } else window.setTimeout(function() {
                        a("#" + a.jgrid.jqID(f.p.knv)).attr("tabindex", "-1").focus()
                    }, 1);
                    i = f.p.colModel[e];
                    c = i.name;
                    if (!("subgrid" === c || "cb" === c || "rn" === c)) {
                        g =
                            a("td:eq(" + e + ")", f.rows[d]);
                        if (!0 === i.editable && !0 === b && !g.hasClass("not-editable-cell")) {
                            0 <= parseInt(f.p.iCol, 10) && 0 <= parseInt(f.p.iRow, 10) && (a("td:eq(" + f.p.iCol + ")", f.rows[f.p.iRow]).removeClass("edit-cell ui-state-highlight"), a(f.rows[f.p.iRow]).removeClass("selected-row ui-state-hover"));
                            a(g).addClass("edit-cell ui-state-highlight");
                            a(f.rows[d]).addClass("selected-row ui-state-hover");
                            try {
                                h = a.unformat.call(f, g, {
                                    rowId: f.rows[d].id,
                                    colModel: i
                                }, e)
                            } catch (j) {
                                h = i.edittype && "textarea" === i.edittype ? a(g).text() :
                                    a(g).html()
                            }
                            f.p.autoencode && (h = a.jgrid.htmlDecode(h));
                            i.edittype || (i.edittype = "text");
                            f.p.savedRow.push({
                                id: d,
                                ic: e,
                                name: c,
                                v: h
                            });
                            if ("&nbsp;" === h || "&#160;" === h || 1 === h.length && 160 === h.charCodeAt(0)) h = "";
                            if (a.isFunction(f.p.formatCell)) {
                                var k = f.p.formatCell.call(f, f.rows[d].id, c, h, d, e);
                                void 0 !== k && (h = k)
                            }
                            a(f).triggerHandler("jqGridBeforeEditCell", [f.rows[d].id, c, h, d, e]);
                            a.isFunction(f.p.beforeEditCell) && f.p.beforeEditCell.call(f, f.rows[d].id, c, h, d, e);
                            var k = a.extend({}, i.editoptions || {}, {
                                    id: d + "_" + c,
                                    name: c,
                                    rowId: f.rows[d].id
                                }),
                                m = a.jgrid.createEl.call(f, i.edittype, k, h, !0, a.extend({}, a.jgrid.ajaxOptions, f.p.ajaxSelectOptions || {}));
                            a(g).html("").append(m).attr("tabindex", "0");
                            a.jgrid.bindEv.call(f, m, k);
                            window.setTimeout(function() {
                                a(m).focus()
                            }, 1);
                            a("input, select, textarea", g).bind("keydown", function(b) {
                                b.keyCode === 27 && (a("input.hasDatepicker", g).length > 0 ? a(".ui-datepicker").is(":hidden") ? a(f).jqGrid("restoreCell", d, e) : a("input.hasDatepicker", g).datepicker("hide") : a(f).jqGrid("restoreCell", d, e));
                                if (b.keyCode ===
                                    13) {
                                    a(f).jqGrid("saveCell", d, e);
                                    return false
                                }
                                if (b.keyCode === 9) {
                                    if (f.grid.hDiv.loading) return false;
                                    b.shiftKey ? a(f).jqGrid("prevCell", d, e) : a(f).jqGrid("nextCell", d, e)
                                }
                                b.stopPropagation()
                            });
                            a(f).triggerHandler("jqGridAfterEditCell", [f.rows[d].id, c, h, d, e]);
                            a.isFunction(f.p.afterEditCell) && f.p.afterEditCell.call(f, f.rows[d].id, c, h, d, e)
                        } else 0 <= parseInt(f.p.iCol, 10) && 0 <= parseInt(f.p.iRow, 10) && (a("td:eq(" + f.p.iCol + ")", f.rows[f.p.iRow]).removeClass("edit-cell ui-state-highlight"), a(f.rows[f.p.iRow]).removeClass("selected-row ui-state-hover")),
                            g.addClass("edit-cell ui-state-highlight"), a(f.rows[d]).addClass("selected-row ui-state-hover"), h = g.html().replace(/\&#160\;/ig, ""), a(f).triggerHandler("jqGridSelectCell", [f.rows[d].id, c, h, d, e]), a.isFunction(f.p.onSelectCell) && f.p.onSelectCell.call(f, f.rows[d].id, c, h, d, e);
                        f.p.iCol = e;
                        f.p.iRow = d
                    }
                }
            })
        },
        saveCell: function(d, e) {
            return this.each(function() {
                var b = this,
                    f;
                if (b.grid && !0 === b.p.cellEdit) {
                    f = 1 <= b.p.savedRow.length ? 0 : null;
                    if (null !== f) {
                        var c = a("td:eq(" + e + ")", b.rows[d]),
                            h, g, i = b.p.colModel[e],
                            j = i.name,
                            k = a.jgrid.jqID(j);
                        switch (i.edittype) {
                            case "select":
                                if (i.editoptions.multiple) {
                                    var k = a("#" + d + "_" + k, b.rows[d]),
                                        m = [];
                                    (h = a(k).val()) ? h.join(","): h = "";
                                    a("option:selected", k).each(function(b, c) {
                                        m[b] = a(c).text()
                                    });
                                    g = m.join(",")
                                } else h = a("#" + d + "_" + k + " option:selected", b.rows[d]).val(), g = a("#" + d + "_" + k + " option:selected", b.rows[d]).text();
                                i.formatter && (g = h);
                                break;
                            case "checkbox":
                                var o = ["Yes", "No"];
                                i.editoptions && (o = i.editoptions.value.split(":"));
                                g = h = a("#" + d + "_" + k, b.rows[d]).is(":checked") ? o[0] : o[1];
                                break;
                            case "password":
                            case "text":
                            case "textarea":
                            case "button":
                                g = h = a("#" + d + "_" + k, b.rows[d]).val();
                                break;
                            case "custom":
                                try {
                                    if (i.editoptions && a.isFunction(i.editoptions.custom_value)) {
                                        h = i.editoptions.custom_value.call(b, a(".customelement", c), "get");
                                        if (void 0 === h) throw "e2";
                                        g = h
                                    } else throw "e1";
                                } catch (n) {
                                    "e1" === n && a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.nodefined, a.jgrid.edit.bClose), "e2" === n ? a.jgrid.info_dialog(a.jgrid.errors.errcap, "function 'custom_value' " + a.jgrid.edit.msg.novalue,
                                        a.jgrid.edit.bClose) : a.jgrid.info_dialog(a.jgrid.errors.errcap, n.message, a.jgrid.edit.bClose)
                                }
                        }
                        if (g !== b.p.savedRow[f].v) {
                            if (f = a(b).triggerHandler("jqGridBeforeSaveCell", [b.rows[d].id, j, h, d, e])) g = h = f;
                            if (a.isFunction(b.p.beforeSaveCell) && (f = b.p.beforeSaveCell.call(b, b.rows[d].id, j, h, d, e))) g = h = f;
                            var l = a.jgrid.checkValues.call(b, h, e);
                            if (!0 === l[0]) {
                                f = a(b).triggerHandler("jqGridBeforeSubmitCell", [b.rows[d].id, j, h, d, e]) || {};
                                a.isFunction(b.p.beforeSubmitCell) && ((f = b.p.beforeSubmitCell.call(b, b.rows[d].id,
                                    j, h, d, e)) || (f = {}));
                                0 < a("input.hasDatepicker", c).length && a("input.hasDatepicker", c).datepicker("hide");
                                if ("remote" === b.p.cellsubmit)
                                    if (b.p.cellurl) {
                                        var p = {};
                                        b.p.autoencode && (h = a.jgrid.htmlEncode(h));
                                        p[j] = h;
                                        o = b.p.prmNames;
                                        i = o.id;
                                        k = o.oper;
                                        p[i] = a.jgrid.stripPref(b.p.idPrefix, b.rows[d].id);
                                        p[k] = o.editoper;
                                        p = a.extend(f, p);
                                        a("#lui_" + a.jgrid.jqID(b.p.id)).show();
                                        b.grid.hDiv.loading = !0;
                                        a.ajax(a.extend({
                                            url: b.p.cellurl,
                                            data: a.isFunction(b.p.serializeCellData) ? b.p.serializeCellData.call(b, p) : p,
                                            type: "POST",
                                            complete: function(f,
                                                i) {
                                                a("#lui_" + b.p.id).hide();
                                                b.grid.hDiv.loading = false;
                                                if (i === "success") {
                                                    var k = a(b).triggerHandler("jqGridAfterSubmitCell", [b, f, p.id, j, h, d, e]) || [true, ""];
                                                    k[0] === true && a.isFunction(b.p.afterSubmitCell) && (k = b.p.afterSubmitCell.call(b, f, p.id, j, h, d, e));
                                                    if (k[0] === true) {
                                                        a(c).empty();
                                                        a(b).jqGrid("setCell", b.rows[d].id, e, g, false, false, true);
                                                        a(c).addClass("dirty-cell");
                                                        a(b.rows[d]).addClass("edited");
                                                        a(b).triggerHandler("jqGridAfterSaveCell", [b.rows[d].id, j, h, d, e]);
                                                        a.isFunction(b.p.afterSaveCell) && b.p.afterSaveCell.call(b,
                                                            b.rows[d].id, j, h, d, e);
                                                        b.p.savedRow.splice(0, 1)
                                                    } else {
                                                        a.jgrid.info_dialog(a.jgrid.errors.errcap, k[1], a.jgrid.edit.bClose);
                                                        a(b).jqGrid("restoreCell", d, e)
                                                    }
                                                }
                                            },
                                            error: function(c, f, g) {
                                                a("#lui_" + a.jgrid.jqID(b.p.id)).hide();
                                                b.grid.hDiv.loading = false;
                                                a(b).triggerHandler("jqGridErrorCell", [c, f, g]);
                                                a.isFunction(b.p.errorCell) ? b.p.errorCell.call(b, c, f, g) : a.jgrid.info_dialog(a.jgrid.errors.errcap, c.status + " : " + c.statusText + "<br/>" + f, a.jgrid.edit.bClose);
                                                a(b).jqGrid("restoreCell", d, e)
                                            }
                                        }, a.jgrid.ajaxOptions, b.p.ajaxCellOptions || {}))
                                    } else try {
                                        a.jgrid.info_dialog(a.jgrid.errors.errcap, a.jgrid.errors.nourl, a.jgrid.edit.bClose), a(b).jqGrid("restoreCell", d, e)
                                    } catch (r) {}
                                    "clientArray" === b.p.cellsubmit && (a(c).empty(), a(b).jqGrid("setCell", b.rows[d].id, e, g, !1, !1, !0), a(c).addClass("dirty-cell"), a(b.rows[d]).addClass("edited"), a(b).triggerHandler("jqGridAfterSaveCell", [b.rows[d].id, j, h, d, e]), a.isFunction(b.p.afterSaveCell) && b.p.afterSaveCell.call(b, b.rows[d].id, j, h, d, e), b.p.savedRow.splice(0, 1))
                            } else try {
                                window.setTimeout(function() {
                                    a.jgrid.info_dialog(a.jgrid.errors.errcap,
                                        h + " " + l[1], a.jgrid.edit.bClose)
                                }, 100), a(b).jqGrid("restoreCell", d, e)
                            } catch (q) {}
                        } else a(b).jqGrid("restoreCell", d, e)
                    }
                    window.setTimeout(function() {
                        a("#" + a.jgrid.jqID(b.p.knv)).attr("tabindex", "-1").focus()
                    }, 0)
                }
            })
        },
        restoreCell: function(d, e) {
            return this.each(function() {
                var b = this,
                    f;
                if (b.grid && !0 === b.p.cellEdit) {
                    f = 1 <= b.p.savedRow.length ? 0 : null;
                    if (null !== f) {
                        var c = a("td:eq(" + e + ")", b.rows[d]);
                        if (a.isFunction(a.fn.datepicker)) try {
                            a("input.hasDatepicker", c).datepicker("hide")
                        } catch (h) {}
                        a(c).empty().attr("tabindex",
                            "-1");
                        a(b).jqGrid("setCell", b.rows[d].id, e, b.p.savedRow[f].v, !1, !1, !0);
                        a(b).triggerHandler("jqGridAfterRestoreCell", [b.rows[d].id, b.p.savedRow[f].v, d, e]);
                        a.isFunction(b.p.afterRestoreCell) && b.p.afterRestoreCell.call(b, b.rows[d].id, b.p.savedRow[f].v, d, e);
                        b.p.savedRow.splice(0, 1)
                    }
                    window.setTimeout(function() {
                        a("#" + b.p.knv).attr("tabindex", "-1").focus()
                    }, 0)
                }
            })
        },
        nextCell: function(d, e) {
            return this.each(function() {
                var b = !1,
                    f;
                if (this.grid && !0 === this.p.cellEdit) {
                    for (f = e + 1; f < this.p.colModel.length; f++)
                        if (!0 ===
                            this.p.colModel[f].editable) {
                            b = f;
                            break
                        }!1 !== b ? a(this).jqGrid("editCell", d, b, !0) : 0 < this.p.savedRow.length && a(this).jqGrid("saveCell", d, e)
                }
            })
        },
        prevCell: function(d, e) {
            return this.each(function() {
                var b = !1,
                    f;
                if (this.grid && !0 === this.p.cellEdit) {
                    for (f = e - 1; 0 <= f; f--)
                        if (!0 === this.p.colModel[f].editable) {
                            b = f;
                            break
                        }!1 !== b ? a(this).jqGrid("editCell", d, b, !0) : 0 < this.p.savedRow.length && a(this).jqGrid("saveCell", d, e)
                }
            })
        },
        GridNav: function() {
            return this.each(function() {
                function d(c, d, e) {
                    if ("v" === e.substr(0, 1)) {
                        var f =
                            a(b.grid.bDiv)[0].clientHeight,
                            h = a(b.grid.bDiv)[0].scrollTop,
                            o = b.rows[c].offsetTop + b.rows[c].clientHeight,
                            n = b.rows[c].offsetTop;
                        "vd" === e && o >= f && (a(b.grid.bDiv)[0].scrollTop = a(b.grid.bDiv)[0].scrollTop + b.rows[c].clientHeight);
                        "vu" === e && n < h && (a(b.grid.bDiv)[0].scrollTop = a(b.grid.bDiv)[0].scrollTop - b.rows[c].clientHeight)
                    }
                    "h" === e && (e = a(b.grid.bDiv)[0].clientWidth, f = a(b.grid.bDiv)[0].scrollLeft, h = b.rows[c].cells[d].offsetLeft, b.rows[c].cells[d].offsetLeft + b.rows[c].cells[d].clientWidth >= e + parseInt(f,
                        10) ? a(b.grid.bDiv)[0].scrollLeft = a(b.grid.bDiv)[0].scrollLeft + b.rows[c].cells[d].clientWidth : h < f && (a(b.grid.bDiv)[0].scrollLeft = a(b.grid.bDiv)[0].scrollLeft - b.rows[c].cells[d].clientWidth))
                }

                function e(a, c) {
                    var d, e;
                    if ("lft" === c) {
                        d = a + 1;
                        for (e = a; 0 <= e; e--)
                            if (!0 !== b.p.colModel[e].hidden) {
                                d = e;
                                break
                            }
                    }
                    if ("rgt" === c) {
                        d = a - 1;
                        for (e = a; e < b.p.colModel.length; e++)
                            if (!0 !== b.p.colModel[e].hidden) {
                                d = e;
                                break
                            }
                    }
                    return d
                }
                var b = this;
                if (b.grid && !0 === b.p.cellEdit) {
                    b.p.knv = b.p.id + "_kn";
                    var f = a("<div style='position:fixed;top:0px;width:1px;height:1px;' tabindex='0'><div tabindex='-1' style='width:1px;height:1px;' id='" +
                            b.p.knv + "'></div></div>"),
                        c, h;
                    a(f).insertBefore(b.grid.cDiv);
                    a("#" + b.p.knv).focus().keydown(function(f) {
                        h = f.keyCode;
                        "rtl" === b.p.direction && (37 === h ? h = 39 : 39 === h && (h = 37));
                        switch (h) {
                            case 38:
                                0 < b.p.iRow - 1 && (d(b.p.iRow - 1, b.p.iCol, "vu"), a(b).jqGrid("editCell", b.p.iRow - 1, b.p.iCol, !1));
                                break;
                            case 40:
                                b.p.iRow + 1 <= b.rows.length - 1 && (d(b.p.iRow + 1, b.p.iCol, "vd"), a(b).jqGrid("editCell", b.p.iRow + 1, b.p.iCol, !1));
                                break;
                            case 37:
                                0 <= b.p.iCol - 1 && (c = e(b.p.iCol - 1, "lft"), d(b.p.iRow, c, "h"), a(b).jqGrid("editCell", b.p.iRow, c, !1));
                                break;
                            case 39:
                                b.p.iCol + 1 <= b.p.colModel.length - 1 && (c = e(b.p.iCol + 1, "rgt"), d(b.p.iRow, c, "h"), a(b).jqGrid("editCell", b.p.iRow, c, !1));
                                break;
                            case 13:
                                0 <= parseInt(b.p.iCol, 10) && 0 <= parseInt(b.p.iRow, 10) && a(b).jqGrid("editCell", b.p.iRow, b.p.iCol, !0);
                                break;
                            default:
                                return !0
                        }
                        return !1
                    })
                }
            })
        },
        getChangedCells: function(d) {
            var e = [];
            d || (d = "all");
            this.each(function() {
                var b = this,
                    f;
                b.grid && !0 === b.p.cellEdit && a(b.rows).each(function(c) {
                    var h = {};
                    a(this).hasClass("edited") && (a("td", this).each(function(e) {
                        f = b.p.colModel[e].name;
                        if ("cb" !== f && "subgrid" !== f)
                            if ("dirty" === d) {
                                if (a(this).hasClass("dirty-cell")) try {
                                    h[f] = a.unformat.call(b, this, {
                                        rowId: b.rows[c].id,
                                        colModel: b.p.colModel[e]
                                    }, e)
                                } catch (i) {
                                    h[f] = a.jgrid.htmlDecode(a(this).html())
                                }
                            } else try {
                                h[f] = a.unformat.call(b, this, {
                                    rowId: b.rows[c].id,
                                    colModel: b.p.colModel[e]
                                }, e)
                            } catch (j) {
                                h[f] = a.jgrid.htmlDecode(a(this).html())
                            }
                    }), h.id = this.id, e.push(h))
                })
            });
            return e
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.extend({
        setSubGrid: function() {
            return this.each(function() {
                var d, e;
                this.p.subGridOptions = a.extend({
                    plusicon: "ui-icon-plus",
                    minusicon: "ui-icon-minus",
                    openicon: "ui-icon-carat-1-sw",
                    expandOnLoad: !1,
                    delayOnLoad: 50,
                    selectOnExpand: !1,
                    selectOnCollapse: !1,
                    reloadOnExpand: !0
                }, this.p.subGridOptions || {});
                this.p.colNames.unshift("");
                this.p.colModel.unshift({
                    name: "subgrid",
                    width: a.jgrid.cell_width ? this.p.subGridWidth + this.p.cellLayout : this.p.subGridWidth,
                    sortable: !1,
                    resizable: !1,
                    hidedlg: !0,
                    search: !1,
                    fixed: !0
                });
                d = this.p.subGridModel;
                if (d[0]) {
                    d[0].align = a.extend([], d[0].align || []);
                    for (e = 0; e < d[0].name.length; e++) d[0].align[e] = d[0].align[e] || "left"
                }
            })
        },
        addSubGridCell: function(a, e) {
            var b = "",
                f, c;
            this.each(function() {
                b = this.formatCol(a, e);
                c = this.p.id;
                f = this.p.subGridOptions.plusicon
            });
            return '<td role="gridcell" aria-describedby="' + c + '_subgrid" class="ui-sgcollapsed sgcollapsed" ' + b + "><a style='cursor:pointer;'><span class='ui-icon " + f + "'></span></a></td>"
        },
        addSubGrid: function(d, e) {
            return this.each(function() {
                var b =
                    this;
                if (b.grid) {
                    var f = function(c, d, e) {
                            d = a("<td align='" + b.p.subGridModel[0].align[e] + "'></td>").html(d);
                            a(c).append(d)
                        },
                        c = function(c, d) {
                            var e, g, i, h = a("<table cellspacing='0' cellpadding='0' border='0'><tbody></tbody></table>"),
                                j = a("<tr></tr>");
                            for (g = 0; g < b.p.subGridModel[0].name.length; g++) e = a("<th class='ui-state-default ui-th-subgrid ui-th-column ui-th-" + b.p.direction + "'></th>"), a(e).html(b.p.subGridModel[0].name[g]), a(e).width(b.p.subGridModel[0].width[g]), a(j).append(e);
                            a(h).append(j);
                            c && (i = b.p.xmlReader.subgrid,
                                a(i.root + " " + i.row, c).each(function() {
                                    j = a("<tr class='ui-widget-content ui-subtblcell'></tr>");
                                    if (!0 === i.repeatitems) a(i.cell, this).each(function(b) {
                                        f(j, a(this).text() || "&#160;", b)
                                    });
                                    else {
                                        var c = b.p.subGridModel[0].mapping || b.p.subGridModel[0].name;
                                        if (c)
                                            for (g = 0; g < c.length; g++) f(j, a(c[g], this).text() || "&#160;", g)
                                    }
                                    a(h).append(j)
                                }));
                            e = a("table:first", b.grid.bDiv).attr("id") + "_";
                            a("#" + a.jgrid.jqID(e + d)).append(h);
                            b.grid.hDiv.loading = !1;
                            a("#load_" + a.jgrid.jqID(b.p.id)).hide();
                            return !1
                        },
                        h = function(c, d) {
                            var e,
                                g, i, h, j, k = a("<table cellspacing='0' cellpadding='0' border='0'><tbody></tbody></table>"),
                                l = a("<tr></tr>");
                            for (g = 0; g < b.p.subGridModel[0].name.length; g++) e = a("<th class='ui-state-default ui-th-subgrid ui-th-column ui-th-" + b.p.direction + "'></th>"), a(e).html(b.p.subGridModel[0].name[g]), a(e).width(b.p.subGridModel[0].width[g]), a(l).append(e);
                            a(k).append(l);
                            if (c && (h = b.p.jsonReader.subgrid, e = a.jgrid.getAccessor(c, h.root), void 0 !== e))
                                for (g = 0; g < e.length; g++) {
                                    i = e[g];
                                    l = a("<tr class='ui-widget-content ui-subtblcell'></tr>");
                                    if (!0 === h.repeatitems) {
                                        h.cell && (i = i[h.cell]);
                                        for (j = 0; j < i.length; j++) f(l, i[j] || "&#160;", j)
                                    } else {
                                        var m = b.p.subGridModel[0].mapping || b.p.subGridModel[0].name;
                                        if (m.length)
                                            for (j = 0; j < m.length; j++) f(l, i[m[j]] || "&#160;", j)
                                    }
                                    a(k).append(l)
                                }
                            g = a("table:first", b.grid.bDiv).attr("id") + "_";
                            a("#" + a.jgrid.jqID(g + d)).append(k);
                            b.grid.hDiv.loading = !1;
                            a("#load_" + a.jgrid.jqID(b.p.id)).hide();
                            return !1
                        },
                        g = function(d) {
                            var e, f, g, i;
                            e = a(d).attr("id");
                            f = {
                                nd_: (new Date).getTime()
                            };
                            f[b.p.prmNames.subgridid] = e;
                            if (!b.p.subGridModel[0]) return !1;
                            if (b.p.subGridModel[0].params)
                                for (i = 0; i < b.p.subGridModel[0].params.length; i++)
                                    for (g = 0; g < b.p.colModel.length; g++) b.p.colModel[g].name === b.p.subGridModel[0].params[i] && (f[b.p.colModel[g].name] = a("td:eq(" + g + ")", d).text().replace(/\&#160\;/ig, ""));
                            if (!b.grid.hDiv.loading) switch (b.grid.hDiv.loading = !0, a("#load_" + a.jgrid.jqID(b.p.id)).show(), b.p.subgridtype || (b.p.subgridtype = b.p.datatype), a.isFunction(b.p.subgridtype) ? b.p.subgridtype.call(b, f) : b.p.subgridtype = b.p.subgridtype.toLowerCase(), b.p.subgridtype) {
                                case "xml":
                                case "json":
                                    a.ajax(a.extend({
                                        type: b.p.mtype,
                                        url: b.p.subGridUrl,
                                        dataType: b.p.subgridtype,
                                        data: a.isFunction(b.p.serializeSubGridData) ? b.p.serializeSubGridData.call(b, f) : f,
                                        complete: function(d) {
                                            b.p.subgridtype === "xml" ? c(d.responseXML, e) : h(a.jgrid.parse(d.responseText), e)
                                        }
                                    }, a.jgrid.ajaxOptions, b.p.ajaxSubgridOptions || {}))
                            }
                            return !1
                        },
                        i, j, k, m = 0,
                        o, n;
                    a.each(b.p.colModel, function() {
                        (!0 === this.hidden || "rn" === this.name || "cb" === this.name) && m++
                    });
                    var l = b.rows.length,
                        p = 1;
                    void 0 !== e && 0 < e && (p = e, l = e + 1);
                    for (; p < l;) a(b.rows[p]).hasClass("jqgrow") && (b.p.scroll &&
                        a(b.rows[p].cells[d]).unbind("click"), a(b.rows[p].cells[d]).bind("click", function() {
                            var c = a(this).parent("tr")[0];
                            n = c.nextSibling;
                            if (a(this).hasClass("sgcollapsed")) {
                                j = b.p.id;
                                i = c.id;
                                if (b.p.subGridOptions.reloadOnExpand === true || b.p.subGridOptions.reloadOnExpand === false && !a(n).hasClass("ui-subgrid")) {
                                    k = d >= 1 ? "<td colspan='" + d + "'>&#160;</td>" : "";
                                    o = a(b).triggerHandler("jqGridSubGridBeforeExpand", [j + "_" + i, i]);
                                    (o = o === false || o === "stop" ? false : true) && a.isFunction(b.p.subGridBeforeExpand) && (o = b.p.subGridBeforeExpand.call(b,
                                        j + "_" + i, i));
                                    if (o === false) return false;
                                    a(c).after("<tr role='row' class='ui-subgrid'>" + k + "<td class='ui-widget-content subgrid-cell'><span class='ui-icon " + b.p.subGridOptions.openicon + "'></span></td><td colspan='" + parseInt(b.p.colNames.length - 1 - m, 10) + "' class='ui-widget-content subgrid-data'><div id=" + j + "_" + i + " class='tablediv'></div></td></tr>");
                                    a(b).triggerHandler("jqGridSubGridRowExpanded", [j + "_" + i, i]);
                                    a.isFunction(b.p.subGridRowExpanded) ? b.p.subGridRowExpanded.call(b, j + "_" + i, i) : g(c)
                                } else a(n).show();
                                a(this).html("<a style='cursor:pointer;'><span class='ui-icon " + b.p.subGridOptions.minusicon + "'></span></a>").removeClass("sgcollapsed").addClass("sgexpanded");
                                b.p.subGridOptions.selectOnExpand && a(b).jqGrid("setSelection", i)
                            } else if (a(this).hasClass("sgexpanded")) {
                                o = a(b).triggerHandler("jqGridSubGridRowColapsed", [j + "_" + i, i]);
                                o = o === false || o === "stop" ? false : true;
                                i = c.id;
                                o && a.isFunction(b.p.subGridRowColapsed) && (o = b.p.subGridRowColapsed.call(b, j + "_" + i, i));
                                if (o === false) return false;
                                b.p.subGridOptions.reloadOnExpand ===
                                    true ? a(n).remove(".ui-subgrid") : a(n).hasClass("ui-subgrid") && a(n).hide();
                                a(this).html("<a style='cursor:pointer;'><span class='ui-icon " + b.p.subGridOptions.plusicon + "'></span></a>").removeClass("sgexpanded").addClass("sgcollapsed");
                                b.p.subGridOptions.selectOnCollapse && a(b).jqGrid("setSelection", i)
                            }
                            return false
                        })), p++;
                    !0 === b.p.subGridOptions.expandOnLoad && a(b.rows).filter(".jqgrow").each(function(b, c) {
                        a(c.cells[0]).click()
                    });
                    b.subGridXml = function(a, b) {
                        c(a, b)
                    };
                    b.subGridJson = function(a, b) {
                        h(a, b)
                    }
                }
            })
        },
        expandSubGridRow: function(d) {
            return this.each(function() {
                if ((this.grid || d) && !0 === this.p.subGrid) {
                    var e = a(this).jqGrid("getInd", d, !0);
                    e && (e = a("td.sgcollapsed", e)[0]) && a(e).trigger("click")
                }
            })
        },
        collapseSubGridRow: function(d) {
            return this.each(function() {
                if ((this.grid || d) && !0 === this.p.subGrid) {
                    var e = a(this).jqGrid("getInd", d, !0);
                    e && (e = a("td.sgexpanded", e)[0]) && a(e).trigger("click")
                }
            })
        },
        toggleSubGridRow: function(d) {
            return this.each(function() {
                if ((this.grid || d) && !0 === this.p.subGrid) {
                    var e = a(this).jqGrid("getInd",
                        d, !0);
                    if (e) {
                        var b = a("td.sgcollapsed", e)[0];
                        b ? a(b).trigger("click") : (b = a("td.sgexpanded", e)[0]) && a(b).trigger("click")
                    }
                }
            })
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.extend({
        setTreeNode: function(d, e) {
            return this.each(function() {
                var b = this;
                if (b.grid && b.p.treeGrid)
                    for (var f = b.p.expColInd, c = b.p.treeReader.expanded_field, h = b.p.treeReader.leaf_field, g = b.p.treeReader.level_field, i = b.p.treeReader.icon_field, j = b.p.treeReader.loaded, k, m, o, n; d < e;) n = a.jgrid.stripPref(b.p.idPrefix, b.rows[d].id), n = b.p.data[b.p._index[n]], "nested" === b.p.treeGridModel && !n[h] && (k = parseInt(n[b.p.treeReader.left_field], 10), m = parseInt(n[b.p.treeReader.right_field], 10), n[h] =
                            m === k + 1 ? "true" : "false", b.rows[d].cells[b.p._treeleafpos].innerHTML = n[h]), k = parseInt(n[g], 10), 0 === b.p.tree_root_level ? (o = k + 1, m = k) : (o = k, m = k - 1), o = "<div class='tree-wrap tree-wrap-" + b.p.direction + "' style='width:" + 18 * o + "px;'>", o += "<div style='" + ("rtl" === b.p.direction ? "right:" : "left:") + 18 * m + "px;' class='ui-icon ", void 0 !== n[j] && (n[j] = "true" === n[j] || !0 === n[j] ? !0 : !1), "true" === n[h] || !0 === n[h] ? (o += (void 0 !== n[i] && "" !== n[i] ? n[i] : b.p.treeIcons.leaf) + " tree-leaf treeclick", n[h] = !0, m = "leaf") : (n[h] = !1, m = ""), n[c] =
                        ("true" === n[c] || !0 === n[c] ? !0 : !1) && (n[j] || void 0 === n[j]), o = !1 === n[c] ? o + (!0 === n[h] ? "'" : b.p.treeIcons.plus + " tree-plus treeclick'") : o + (!0 === n[h] ? "'" : b.p.treeIcons.minus + " tree-minus treeclick'"), o += "></div></div>", a(b.rows[d].cells[f]).wrapInner("<span class='cell-wrapper" + m + "'></span>").prepend(o), k !== parseInt(b.p.tree_root_level, 10) && ((n = (n = a(b).jqGrid("getNodeParent", n)) && n.hasOwnProperty(c) ? n[c] : !0) || a(b.rows[d]).css("display", "none")), a(b.rows[d].cells[f]).find("div.treeclick").bind("click", function(d) {
                            d =
                                a.jgrid.stripPref(b.p.idPrefix, a(d.target || d.srcElement, b.rows).closest("tr.jqgrow")[0].id);
                            d = b.p._index[d];
                            if (!b.p.data[d][h])
                                if (b.p.data[d][c]) {
                                    a(b).jqGrid("collapseRow", b.p.data[d]);
                                    a(b).jqGrid("collapseNode", b.p.data[d])
                                } else {
                                    a(b).jqGrid("expandRow", b.p.data[d]);
                                    a(b).jqGrid("expandNode", b.p.data[d])
                                }
                            return false
                        }), !0 === b.p.ExpandColClick && a(b.rows[d].cells[f]).find("span.cell-wrapper").css("cursor", "pointer").bind("click", function(d) {
                            var d = a.jgrid.stripPref(b.p.idPrefix, a(d.target || d.srcElement,
                                    b.rows).closest("tr.jqgrow")[0].id),
                                e = b.p._index[d];
                            if (!b.p.data[e][h])
                                if (b.p.data[e][c]) {
                                    a(b).jqGrid("collapseRow", b.p.data[e]);
                                    a(b).jqGrid("collapseNode", b.p.data[e])
                                } else {
                                    a(b).jqGrid("expandRow", b.p.data[e]);
                                    a(b).jqGrid("expandNode", b.p.data[e])
                                }
                            a(b).jqGrid("setSelection", d);
                            return false
                        }), d++
            })
        },
        setTreeGrid: function() {
            return this.each(function() {
                var d = this,
                    e = 0,
                    b, f = !1,
                    c, h, g = [];
                if (d.p.treeGrid) {
                    d.p.treedatatype || a.extend(d.p, {
                        treedatatype: d.p.datatype
                    });
                    d.p.subGrid = !1;
                    d.p.altRows = !1;
                    d.p.pgbuttons = !1;
                    d.p.pginput = !1;
                    d.p.gridview = !0;
                    null === d.p.rowTotal && (d.p.rowNum = 1E4);
                    d.p.multiselect = !1;
                    d.p.rowList = [];
                    d.p.expColInd = 0;
                    b = "ui-icon-triangle-1-" + ("rtl" === d.p.direction ? "w" : "e");
                    d.p.treeIcons = a.extend({
                        plus: b,
                        minus: "ui-icon-triangle-1-s",
                        leaf: "ui-icon-radio-off"
                    }, d.p.treeIcons || {});
                    "nested" === d.p.treeGridModel ? d.p.treeReader = a.extend({
                            level_field: "level",
                            left_field: "lft",
                            right_field: "rgt",
                            leaf_field: "isLeaf",
                            expanded_field: "expanded",
                            loaded: "loaded",
                            icon_field: "icon"
                        }, d.p.treeReader) : "adjacency" ===
                        d.p.treeGridModel && (d.p.treeReader = a.extend({
                            level_field: "level",
                            parent_id_field: "parent",
                            leaf_field: "isLeaf",
                            expanded_field: "expanded",
                            loaded: "loaded",
                            icon_field: "icon"
                        }, d.p.treeReader));
                    for (c in d.p.colModel)
                        if (d.p.colModel.hasOwnProperty(c))
                            for (h in b = d.p.colModel[c].name, b === d.p.ExpandColumn && !f && (f = !0, d.p.expColInd = e), e++, d.p.treeReader) d.p.treeReader.hasOwnProperty(h) && d.p.treeReader[h] === b && g.push(b);
                    a.each(d.p.treeReader, function(b, c) {
                        if (c && a.inArray(c, g) === -1) {
                            if (b === "leaf_field") d.p._treeleafpos =
                                e;
                            e++;
                            d.p.colNames.push(c);
                            d.p.colModel.push({
                                name: c,
                                width: 1,
                                hidden: true,
                                sortable: false,
                                resizable: false,
                                hidedlg: true,
                                editable: true,
                                search: false
                            })
                        }
                    })
                }
            })
        },
        expandRow: function(d) {
            this.each(function() {
                var e = this;
                if (e.grid && e.p.treeGrid) {
                    var b = a(e).jqGrid("getNodeChildren", d),
                        f = e.p.treeReader.expanded_field;
                    a(b).each(function() {
                        var b = e.p.idPrefix + a.jgrid.getAccessor(this, e.p.localReader.id);
                        a(a(e).jqGrid("getGridRowById", b)).css("display", "");
                        this[f] && a(e).jqGrid("expandRow", this)
                    })
                }
            })
        },
        collapseRow: function(d) {
            this.each(function() {
                var e =
                    this;
                if (e.grid && e.p.treeGrid) {
                    var b = a(e).jqGrid("getNodeChildren", d),
                        f = e.p.treeReader.expanded_field;
                    a(b).each(function() {
                        var b = e.p.idPrefix + a.jgrid.getAccessor(this, e.p.localReader.id);
                        a(a(e).jqGrid("getGridRowById", b)).css("display", "none");
                        this[f] && a(e).jqGrid("collapseRow", this)
                    })
                }
            })
        },
        getRootNodes: function() {
            var d = [];
            this.each(function() {
                var e = this;
                if (e.grid && e.p.treeGrid) switch (e.p.treeGridModel) {
                    case "nested":
                        var b = e.p.treeReader.level_field;
                        a(e.p.data).each(function() {
                            parseInt(this[b], 10) ===
                                parseInt(e.p.tree_root_level, 10) && d.push(this)
                        });
                        break;
                    case "adjacency":
                        var f = e.p.treeReader.parent_id_field;
                        a(e.p.data).each(function() {
                            (null === this[f] || "null" === ("" + this[f]).toLowerCase()) && d.push(this)
                        })
                }
            });
            return d
        },
        getNodeDepth: function(d) {
            var e = null;
            this.each(function() {
                if (this.grid && this.p.treeGrid) switch (this.p.treeGridModel) {
                    case "nested":
                        e = parseInt(d[this.p.treeReader.level_field], 10) - parseInt(this.p.tree_root_level, 10);
                        break;
                    case "adjacency":
                        e = a(this).jqGrid("getNodeAncestors", d).length
                }
            });
            return e
        },
        getNodeParent: function(d) {
            var e = null;
            this.each(function() {
                if (this.grid && this.p.treeGrid) switch (this.p.treeGridModel) {
                    case "nested":
                        var b = this.p.treeReader.left_field,
                            f = this.p.treeReader.right_field,
                            c = this.p.treeReader.level_field,
                            h = parseInt(d[b], 10),
                            g = parseInt(d[f], 10),
                            i = parseInt(d[c], 10);
                        a(this.p.data).each(function() {
                            if (parseInt(this[c], 10) === i - 1 && parseInt(this[b], 10) < h && parseInt(this[f], 10) > g) return e = this, !1
                        });
                        break;
                    case "adjacency":
                        for (var j = this.p.treeReader.parent_id_field, k = this.p.localReader.id,
                            m = this.p._index[d[k]]; m--;)
                            if (this.p.data[m][k] === a.jgrid.stripPref(this.p.idPrefix, d[j])) {
                                e = this.p.data[m];
                                break
                            }
                }
            });
            return e
        },
        getNodeChildren: function(d) {
            var e = [];
            this.each(function() {
                var b = this;
                if (b.grid && b.p.treeGrid) switch (b.p.treeGridModel) {
                    case "nested":
                        var f = b.p.treeReader.left_field,
                            c = b.p.treeReader.right_field,
                            h = b.p.treeReader.level_field,
                            g = parseInt(d[f], 10),
                            i = parseInt(d[c], 10),
                            j = parseInt(d[h], 10);
                        a(this.p.data).each(function() {
                            parseInt(this[h], 10) === j + 1 && (parseInt(this[f], 10) > g && parseInt(this[c],
                                10) < i) && e.push(this)
                        });
                        break;
                    case "adjacency":
                        var k = b.p.treeReader.parent_id_field,
                            m = b.p.localReader.id;
                        a(this.p.data).each(function() {
                            this[k] == a.jgrid.stripPref(b.p.idPrefix, d[m]) && e.push(this)
                        })
                }
            });
            return e
        },
        getFullTreeNode: function(d) {
            var e = [];
            this.each(function() {
                var b = this,
                    f;
                if (b.grid && b.p.treeGrid) switch (b.p.treeGridModel) {
                    case "nested":
                        var c = b.p.treeReader.left_field,
                            h = b.p.treeReader.right_field,
                            g = b.p.treeReader.level_field,
                            i = parseInt(d[c], 10),
                            j = parseInt(d[h], 10),
                            k = parseInt(d[g], 10);
                        a(this.p.data).each(function() {
                            parseInt(this[g],
                                10) >= k && (parseInt(this[c], 10) >= i && parseInt(this[c], 10) <= j) && e.push(this)
                        });
                        break;
                    case "adjacency":
                        if (d) {
                            e.push(d);
                            var m = b.p.treeReader.parent_id_field,
                                o = b.p.localReader.id;
                            a(this.p.data).each(function(c) {
                                f = e.length;
                                for (c = 0; c < f; c++)
                                    if (a.jgrid.stripPref(b.p.idPrefix, e[c][o]) === this[m]) {
                                        e.push(this);
                                        break
                                    }
                            })
                        }
                }
            });
            return e
        },
        getNodeAncestors: function(d) {
            var e = [];
            this.each(function() {
                if (this.grid && this.p.treeGrid)
                    for (var b = a(this).jqGrid("getNodeParent", d); b;) e.push(b), b = a(this).jqGrid("getNodeParent", b)
            });
            return e
        },
        isVisibleNode: function(d) {
            var e = !0;
            this.each(function() {
                if (this.grid && this.p.treeGrid) {
                    var b = a(this).jqGrid("getNodeAncestors", d),
                        f = this.p.treeReader.expanded_field;
                    a(b).each(function() {
                        e = e && this[f];
                        if (!e) return !1
                    })
                }
            });
            return e
        },
        isNodeLoaded: function(d) {
            var e;
            this.each(function() {
                if (this.grid && this.p.treeGrid) {
                    var b = this.p.treeReader.leaf_field,
                        f = this.p.treeReader.loaded;
                    e = void 0 !== d ? void 0 !== d[f] ? d[f] : d[b] || 0 < a(this).jqGrid("getNodeChildren", d).length ? !0 : !1 : !1
                }
            });
            return e
        },
        expandNode: function(d) {
            return this.each(function() {
                if (this.grid &&
                    this.p.treeGrid) {
                    var e = this.p.treeReader.expanded_field,
                        b = this.p.treeReader.parent_id_field,
                        f = this.p.treeReader.loaded,
                        c = this.p.treeReader.level_field,
                        h = this.p.treeReader.left_field,
                        g = this.p.treeReader.right_field;
                    if (!d[e]) {
                        var i = a.jgrid.getAccessor(d, this.p.localReader.id),
                            j = a("#" + this.p.idPrefix + a.jgrid.jqID(i), this.grid.bDiv)[0],
                            k = this.p._index[i];
                        a(this).jqGrid("isNodeLoaded", this.p.data[k]) ? (d[e] = !0, a("div.treeclick", j).removeClass(this.p.treeIcons.plus + " tree-plus").addClass(this.p.treeIcons.minus +
                            " tree-minus")) : this.grid.hDiv.loading || (d[e] = !0, a("div.treeclick", j).removeClass(this.p.treeIcons.plus + " tree-plus").addClass(this.p.treeIcons.minus + " tree-minus"), this.p.treeANode = j.rowIndex, this.p.datatype = this.p.treedatatype, "nested" === this.p.treeGridModel ? a(this).jqGrid("setGridParam", {
                                postData: {
                                    nodeid: i,
                                    n_left: d[h],
                                    n_right: d[g],
                                    n_level: d[c]
                                }
                            }) : a(this).jqGrid("setGridParam", {
                                postData: {
                                    nodeid: i,
                                    parentid: d[b],
                                    n_level: d[c]
                                }
                            }), a(this).trigger("reloadGrid"), d[f] = !0, "nested" === this.p.treeGridModel ?
                            a(this).jqGrid("setGridParam", {
                                postData: {
                                    nodeid: "",
                                    n_left: "",
                                    n_right: "",
                                    n_level: ""
                                }
                            }) : a(this).jqGrid("setGridParam", {
                                postData: {
                                    nodeid: "",
                                    parentid: "",
                                    n_level: ""
                                }
                            }))
                    }
                }
            })
        },
        collapseNode: function(d) {
            return this.each(function() {
                if (this.grid && this.p.treeGrid) {
                    var e = this.p.treeReader.expanded_field;
                    d[e] && (d[e] = !1, e = a.jgrid.getAccessor(d, this.p.localReader.id), e = a("#" + this.p.idPrefix + a.jgrid.jqID(e), this.grid.bDiv)[0], a("div.treeclick", e).removeClass(this.p.treeIcons.minus + " tree-minus").addClass(this.p.treeIcons.plus +
                        " tree-plus"))
                }
            })
        },
        SortTree: function(d, e, b, f) {
            return this.each(function() {
                if (this.grid && this.p.treeGrid) {
                    var c, h, g, i = [],
                        j = this,
                        k;
                    c = a(this).jqGrid("getRootNodes");
                    c = a.jgrid.from(c);
                    c.orderBy(d, e, b, f);
                    k = c.select();
                    c = 0;
                    for (h = k.length; c < h; c++) g = k[c], i.push(g), a(this).jqGrid("collectChildrenSortTree", i, g, d, e, b, f);
                    a.each(i, function(b) {
                        var c = a.jgrid.getAccessor(this, j.p.localReader.id);
                        a("#" + a.jgrid.jqID(j.p.id) + " tbody tr:eq(" + b + ")").after(a("tr#" + a.jgrid.jqID(c), j.grid.bDiv))
                    });
                    i = k = c = null
                }
            })
        },
        collectChildrenSortTree: function(d,
            e, b, f, c, h) {
            return this.each(function() {
                if (this.grid && this.p.treeGrid) {
                    var g, i, j, k;
                    g = a(this).jqGrid("getNodeChildren", e);
                    g = a.jgrid.from(g);
                    g.orderBy(b, f, c, h);
                    k = g.select();
                    g = 0;
                    for (i = k.length; g < i; g++) j = k[g], d.push(j), a(this).jqGrid("collectChildrenSortTree", d, j, b, f, c, h)
                }
            })
        },
        setTreeRow: function(d, e) {
            var b = !1;
            this.each(function() {
                this.grid && this.p.treeGrid && (b = a(this).jqGrid("setRowData", d, e))
            });
            return b
        },
        delTreeNode: function(d) {
            return this.each(function() {
                var e = this.p.localReader.id,
                    b, f = this.p.treeReader.left_field,
                    c = this.p.treeReader.right_field,
                    h, g, i;
                if (this.grid && this.p.treeGrid && (b = this.p._index[d], void 0 !== b)) {
                    h = parseInt(this.p.data[b][c], 10);
                    g = h - parseInt(this.p.data[b][f], 10) + 1;
                    var j = a(this).jqGrid("getFullTreeNode", this.p.data[b]);
                    if (0 < j.length)
                        for (b = 0; b < j.length; b++) a(this).jqGrid("delRowData", j[b][e]);
                    if ("nested" === this.p.treeGridModel) {
                        e = a.jgrid.from(this.p.data).greater(f, h, {
                            stype: "integer"
                        }).select();
                        if (e.length)
                            for (i in e) e.hasOwnProperty(i) && (e[i][f] = parseInt(e[i][f], 10) - g);
                        e = a.jgrid.from(this.p.data).greater(c,
                            h, {
                                stype: "integer"
                            }).select();
                        if (e.length)
                            for (i in e) e.hasOwnProperty(i) && (e[i][c] = parseInt(e[i][c], 10) - g)
                    }
                }
            })
        },
        addChildNode: function(d, e, b, f) {
            var c = this[0];
            if (b) {
                var h = c.p.treeReader.expanded_field,
                    g = c.p.treeReader.leaf_field,
                    i = c.p.treeReader.level_field,
                    j = c.p.treeReader.parent_id_field,
                    k = c.p.treeReader.left_field,
                    m = c.p.treeReader.right_field,
                    o = c.p.treeReader.loaded,
                    n, l, p, r, q;
                n = 0;
                var s = e,
                    t;
                void 0 === f && (f = !1);
                if (void 0 === d || null === d) {
                    q = c.p.data.length - 1;
                    if (0 <= q)
                        for (; 0 <= q;) n = Math.max(n, parseInt(c.p.data[q][c.p.localReader.id],
                            10)), q--;
                    d = n + 1
                }
                var w = a(c).jqGrid("getInd", e);
                t = !1;
                if (void 0 === e || null === e || "" === e) s = e = null, n = "last", r = c.p.tree_root_level, q = c.p.data.length + 1;
                else if (n = "after", l = c.p._index[e], p = c.p.data[l], e = p[c.p.localReader.id], r = parseInt(p[i], 10) + 1, q = a(c).jqGrid("getFullTreeNode", p), q.length ? (s = q = q[q.length - 1][c.p.localReader.id], q = a(c).jqGrid("getInd", s) + 1) : q = a(c).jqGrid("getInd", e) + 1, p[g]) t = !0, p[h] = !0, a(c.rows[w]).find("span.cell-wrapperleaf").removeClass("cell-wrapperleaf").addClass("cell-wrapper").end().find("div.tree-leaf").removeClass(c.p.treeIcons.leaf +
                    " tree-leaf").addClass(c.p.treeIcons.minus + " tree-minus"), c.p.data[l][g] = !1, p[o] = !0;
                l = q + 1;
                void 0 === b[h] && (b[h] = !1);
                void 0 === b[o] && (b[o] = !1);
                b[i] = r;
                void 0 === b[g] && (b[g] = !0);
                "adjacency" === c.p.treeGridModel && (b[j] = e);
                if ("nested" === c.p.treeGridModel) {
                    var v;
                    if (null !== e) {
                        g = parseInt(p[m], 10);
                        i = a.jgrid.from(c.p.data);
                        i = i.greaterOrEquals(m, g, {
                            stype: "integer"
                        });
                        i = i.select();
                        if (i.length)
                            for (v in i) i.hasOwnProperty(v) && (i[v][k] = i[v][k] > g ? parseInt(i[v][k], 10) + 2 : i[v][k], i[v][m] = i[v][m] >= g ? parseInt(i[v][m], 10) +
                                2 : i[v][m]);
                        b[k] = g;
                        b[m] = g + 1
                    } else {
                        g = parseInt(a(c).jqGrid("getCol", m, !1, "max"), 10);
                        i = a.jgrid.from(c.p.data).greater(k, g, {
                            stype: "integer"
                        }).select();
                        if (i.length)
                            for (v in i) i.hasOwnProperty(v) && (i[v][k] = parseInt(i[v][k], 10) + 2);
                        i = a.jgrid.from(c.p.data).greater(m, g, {
                            stype: "integer"
                        }).select();
                        if (i.length)
                            for (v in i) i.hasOwnProperty(v) && (i[v][m] = parseInt(i[v][m], 10) + 2);
                        b[k] = g + 1;
                        b[m] = g + 2
                    }
                }
                if (null === e || a(c).jqGrid("isNodeLoaded", p) || t) a(c).jqGrid("addRowData", d, b, n, s), a(c).jqGrid("setTreeNode", q, l);
                p && (!p[h] &&
                    f) && a(c.rows[w]).find("div.treeclick").click()
            }
        }
    })
})(jQuery);
(function(a) {
    a.extend(a.jgrid, {
        template: function(d) {
            var e = a.makeArray(arguments).slice(1),
                b, f = e.length;
            null == d && (d = "");
            return d.replace(/\{([\w\-]+)(?:\:([\w\.]*)(?:\((.*?)?\))?)?\}/g, function(c, d) {
                if (!isNaN(parseInt(d, 10))) return e[parseInt(d, 10)];
                for (b = 0; b < f; b++)
                    if (a.isArray(e[b]))
                        for (var g = e[b], i = g.length; i--;)
                            if (d === g[i].nm) return g[i].v
            })
        }
    });
    a.jgrid.extend({
        groupingSetup: function() {
            return this.each(function() {
                var d, e, b = this.p.colModel,
                    f = this.p.groupingView;
                if (null !== f && ("object" === typeof f ||
                    a.isFunction(f)))
                    if (f.groupField.length) {
                        void 0 === f.visibiltyOnNextGrouping && (f.visibiltyOnNextGrouping = []);
                        f.lastvalues = [];
                        f._locgr || (f.groups = []);
                        f.counters = [];
                        for (d = 0; d < f.groupField.length; d++) f.groupOrder[d] || (f.groupOrder[d] = "asc"), f.groupText[d] || (f.groupText[d] = "{0}"), "boolean" !== typeof f.groupColumnShow[d] && (f.groupColumnShow[d] = !0), "boolean" !== typeof f.groupSummary[d] && (f.groupSummary[d] = !1), f.groupSummaryPos[d] || (f.groupSummaryPos[d] = "footer"), !0 === f.groupColumnShow[d] ? (f.visibiltyOnNextGrouping[d] = !0, a(this).jqGrid("showCol", f.groupField[d])) : (f.visibiltyOnNextGrouping[d] = a("#" + a.jgrid.jqID(this.p.id + "_" + f.groupField[d])).is(":visible"), a(this).jqGrid("hideCol", f.groupField[d]));
                        f.summary = [];
                        f.hideFirstGroupCol && (f.formatDisplayField[0] = function(a) {
                            return a
                        });
                        d = 0;
                        for (e = b.length; d < e; d++) f.hideFirstGroupCol && (!b[d].hidden && f.groupField[0] === b[d].name) && (b[d].formatter = function() {
                            return ""
                        }), b[d].summaryType && (b[d].summaryDivider ? f.summary.push({
                            nm: b[d].name,
                            st: b[d].summaryType,
                            v: "",
                            sd: b[d].summaryDivider,
                            vd: "",
                            sr: b[d].summaryRound,
                            srt: b[d].summaryRoundType || "round"
                        }) : f.summary.push({
                            nm: b[d].name,
                            st: b[d].summaryType,
                            v: "",
                            sr: b[d].summaryRound,
                            srt: b[d].summaryRoundType || "round"
                        }))
                    } else this.p.grouping = !1;
                else this.p.grouping = !1
            })
        },
        groupingPrepare: function(d, e) {
            this.each(function() {
                var b = this.p.groupingView,
                    f = this,
                    c, h = b.groupField.length,
                    g, i, j, k = 0;
                for (c = 0; c < h; c++) g = b.groupField[c], j = b.displayField[c], i = d[g], j = null == j ? null : d[j], null == j && (j = i), void 0 !== i && (0 === e ? (b.groups.push({
                    idx: c,
                    dataIndex: g,
                    value: i,
                    displayValue: j,
                    startRow: e,
                    cnt: 1,
                    summary: []
                }), b.lastvalues[c] = i, b.counters[c] = {
                    cnt: 1,
                    pos: b.groups.length - 1,
                    summary: a.extend(!0, [], b.summary)
                }) : "object" !== typeof i && (a.isArray(b.isInTheSameGroup) && a.isFunction(b.isInTheSameGroup[c]) ? !b.isInTheSameGroup[c].call(f, b.lastvalues[c], i, c, b) : b.lastvalues[c] !== i) ? (b.groups.push({
                    idx: c,
                    dataIndex: g,
                    value: i,
                    displayValue: j,
                    startRow: e,
                    cnt: 1,
                    summary: []
                }), b.lastvalues[c] = i, k = 1, b.counters[c] = {
                    cnt: 1,
                    pos: b.groups.length - 1,
                    summary: a.extend(!0, [], b.summary)
                }) : 1 === k ? (b.groups.push({
                    idx: c,
                    dataIndex: g,
                    value: i,
                    displayValue: j,
                    startRow: e,
                    cnt: 1,
                    summary: []
                }), b.lastvalues[c] = i, b.counters[c] = {
                    cnt: 1,
                    pos: b.groups.length - 1,
                    summary: a.extend(!0, [], b.summary)
                }) : (b.counters[c].cnt += 1, b.groups[b.counters[c].pos].cnt = b.counters[c].cnt), a.each(b.counters[c].summary, function() {
                    if (a.isFunction(this.st)) this.v = this.st.call(f, this.v, this.nm, d);
                    else {
                        this.v = a(f).jqGrid("groupingCalculations.handler", this.st, this.v, this.nm, this.sr, this.srt, d);
                        if (this.st.toLowerCase() === "avg" && this.sd) this.vd = a(f).jqGrid("groupingCalculations.handler",
                            this.st, this.vd, this.sd, this.sr, this.srt, d)
                    }
                }), b.groups[b.counters[c].pos].summary = b.counters[c].summary)
            });
            return this
        },
        groupingToggle: function(d) {
            this.each(function() {
                var e = this.p.groupingView,
                    b = d.split("_"),
                    f = parseInt(b[b.length - 2], 10);
                b.splice(b.length - 2, 2);
                var c = b.join("_"),
                    b = e.minusicon,
                    h = e.plusicon,
                    g = a("#" + a.jgrid.jqID(d)),
                    g = g.length ? g[0].nextSibling : null,
                    i = a("#" + a.jgrid.jqID(d) + " span.tree-wrap-" + this.p.direction),
                    j = function(b) {
                        b = a.map(b.split(" "), function(a) {
                            if (a.substring(0, c.length + 1) ===
                                c + "_") return parseInt(a.substring(c.length + 1), 10)
                        });
                        return 0 < b.length ? b[0] : void 0
                    },
                    k, m = !1,
                    o = this.p.frozenColumns ? this.p.id + "_frozen" : !1,
                    n = o ? a("#" + a.jgrid.jqID(d), "#" + a.jgrid.jqID(o)) : !1,
                    n = n && n.length ? n[0].nextSibling : null;
                if (i.hasClass(b)) {
                    if (e.showSummaryOnHide) {
                        if (g)
                            for (; g && !(a(g).hasClass("jqfoot") && parseInt(a(g).attr("jqfootlevel"), 10) <= f);) a(g).hide(), g = g.nextSibling, o && (a(n).hide(), n = n.nextSibling)
                    } else if (g)
                        for (; g;) {
                            e = j(g.className);
                            if (void 0 !== e && e <= f) break;
                            a(g).hide();
                            g = g.nextSibling;
                            o &&
                                (a(n).hide(), n = n.nextSibling)
                        }
                    i.removeClass(b).addClass(h);
                    m = !0
                } else {
                    if (g)
                        for (k = void 0; g;) {
                            e = j(g.className);
                            void 0 === k && (k = void 0 === e);
                            if (void 0 !== e) {
                                if (e <= f) break;
                                e === f + 1 && (a(g).show().find(">td>span.tree-wrap-" + this.p.direction).removeClass(b).addClass(h), o && a(n).show().find(">td>span.tree-wrap-" + this.p.direction).removeClass(b).addClass(h))
                            } else k && (a(g).show(), o && a(n).show());
                            g = g.nextSibling;
                            o && (n = n.nextSibling)
                        }
                    i.removeClass(h).addClass(b)
                }
                a(this).triggerHandler("jqGridGroupingClickGroup", [d,
                    m
                ]);
                a.isFunction(this.p.onClickGroup) && this.p.onClickGroup.call(this, d, m)
            });
            return !1
        },
        groupingRender: function(d, e, b, f) {
            return this.each(function() {
                function c(a, b, c) {
                    var d = !1;
                    if (0 === b) d = c[a];
                    else {
                        var e = c[a].idx;
                        if (0 === e) d = c[a];
                        else
                            for (; 0 <= a; a--)
                                if (c[a].idx === e - b) {
                                    d = c[a];
                                    break
                                }
                    }
                    return d
                }

                function h(b, d, f, i) {
                    var h = c(b, d, f),
                        j = g.p.colModel,
                        k, l = h.cnt,
                        b = "",
                        m;
                    for (m = i; m < e; m++) {
                        var n = "<td " + g.formatCol(m, 1, "") + ">&#160;</td>",
                            o = "{0}";
                        a.each(h.summary, function() {
                            if (this.nm === j[m].name) {
                                j[m].summaryTpl && (o = j[m].summaryTpl);
                                "string" === typeof this.st && "avg" === this.st.toLowerCase() && (this.sd && this.vd ? this.v /= this.vd : this.v && 0 < l && (this.v /= l));
                                try {
                                    this.groupCount = h.cnt, this.groupIndex = h.dataIndex, this.groupValue = h.value, k = g.formatter("", this.v, m, this)
                                } catch (b) {
                                    k = this.v
                                }
                                n = "<td " + g.formatCol(m, 1, "") + ">" + a.jgrid.format(o, k) + "</td>";
                                return !1
                            }
                        });
                        b += n
                    }
                    return b
                }
                var g = this,
                    i = g.p.groupingView,
                    j = "",
                    k = "",
                    m, o, n = i.groupCollapse ? i.plusicon : i.minusicon,
                    l, p = [],
                    r = i.groupField.length,
                    n = n + (" tree-wrap-" + g.p.direction);
                a.each(g.p.colModel,
                    function(a, b) {
                        var c;
                        for (c = 0; c < r; c++)
                            if (i.groupField[c] === b.name) {
                                p[c] = a;
                                break
                            }
                    });
                var q = 0,
                    s = a.makeArray(i.groupSummary),
                    t;
                s.reverse();
                t = g.p.multiselect ? ' colspan="2"' : "";
                a.each(i.groups, function(c, v) {
                    if (i._locgr && !(v.startRow + v.cnt > (b - 1) * f && v.startRow < b * f)) return !0;
                    q++;
                    o = g.p.id + "ghead_" + v.idx;
                    m = o + "_" + c;
                    k = "<span style='cursor:pointer;' class='ui-icon " + n + "' onclick=\"jQuery('#" + a.jgrid.jqID(g.p.id) + "').jqGrid('groupingToggle','" + m + "');return false;\"></span>";
                    try {
                        a.isArray(i.formatDisplayField) && a.isFunction(i.formatDisplayField[v.idx]) ?
                            (v.displayValue = i.formatDisplayField[v.idx].call(g, v.displayValue, v.value, g.p.colModel[p[v.idx]], v.idx, i), l = v.displayValue) : l = g.formatter(m, v.displayValue, p[v.idx], v.value)
                    } catch (x) {
                        l = v.displayValue
                    }
                    "header" === i.groupSummaryPos[v.idx] ? (j += '<tr id="' + m + '"' + (i.groupCollapse && 0 < v.idx ? ' style="display:none;" ' : " ") + 'role="row" class= "ui-widget-content jqgroup ui-row-' + g.p.direction + " " + o + '"><td style="padding-left:' + 12 * v.idx + 'px;"' + t + ">" + k + a.jgrid.template(i.groupText[v.idx], l, v.cnt, v.summary) + "</td>",
                        j += h(c, v.idx - 1, i.groups, "" === t ? 1 : 2), j += "</tr>") : j += '<tr id="' + m + '"' + (i.groupCollapse && 0 < v.idx ? ' style="display:none;" ' : " ") + 'role="row" class= "ui-widget-content jqgroup ui-row-' + g.p.direction + " " + o + '"><td style="padding-left:' + 12 * v.idx + 'px;" colspan="' + e + '">' + k + a.jgrid.template(i.groupText[v.idx], l, v.cnt, v.summary) + "</td></tr>";
                    if (r - 1 === v.idx) {
                        var H = i.groups[c + 1],
                            y, D = 0;
                        y = v.startRow;
                        var z = void 0 !== H ? H.startRow : i.groups[c].startRow + i.groups[c].cnt;
                        i._locgr && (D = (b - 1) * f, D > v.startRow && (y = D));
                        for (; y <
                            z && d[y - D]; y++) j += d[y - D].join("");
                        if ("header" !== i.groupSummaryPos[v.idx]) {
                            var u;
                            if (void 0 !== H) {
                                for (u = 0; u < i.groupField.length && H.dataIndex !== i.groupField[u]; u++);
                                q = i.groupField.length - u
                            }
                            for (H = 0; H < q; H++) s[H] && (D = "", i.groupCollapse && !i.showSummaryOnHide && (D = ' style="display:none;"'), j += "<tr" + D + ' jqfootlevel="' + (v.idx - H) + '" role="row" class="ui-widget-content jqfoot ui-row-' + g.p.direction + '">', j += h(c, H, i.groups, 0), j += "</tr>");
                            q = u
                        }
                    }
                });
                a("#" + a.jgrid.jqID(g.p.id) + " tbody:first").append(j);
                j = null
            })
        },
        groupingGroupBy: function(d,
            e) {
            return this.each(function() {
                "string" === typeof d && (d = [d]);
                var b = this.p.groupingView;
                this.p.grouping = !0;
                void 0 === b.visibiltyOnNextGrouping && (b.visibiltyOnNextGrouping = []);
                var f;
                for (f = 0; f < b.groupField.length; f++) !b.groupColumnShow[f] && b.visibiltyOnNextGrouping[f] && a(this).jqGrid("showCol", b.groupField[f]);
                for (f = 0; f < d.length; f++) b.visibiltyOnNextGrouping[f] = a("#" + a.jgrid.jqID(this.p.id) + "_" + a.jgrid.jqID(d[f])).is(":visible");
                this.p.groupingView = a.extend(this.p.groupingView, e || {});
                b.groupField = d;
                a(this).trigger("reloadGrid")
            })
        },
        groupingRemove: function(d) {
            return this.each(function() {
                void 0 === d && (d = !0);
                this.p.grouping = !1;
                if (!0 === d) {
                    var e = this.p.groupingView,
                        b;
                    for (b = 0; b < e.groupField.length; b++) !e.groupColumnShow[b] && e.visibiltyOnNextGrouping[b] && a(this).jqGrid("showCol", e.groupField);
                    a("tr.jqgroup, tr.jqfoot", "#" + a.jgrid.jqID(this.p.id) + " tbody:first").remove();
                    a("tr.jqgrow:hidden", "#" + a.jgrid.jqID(this.p.id) + " tbody:first").show()
                } else a(this).trigger("reloadGrid")
            })
        },
        groupingCalculations: {
            handler: function(a, e, b, f, c, h) {
                var g = {
                    sum: function() {
                        return parseFloat(e || 0) + parseFloat(h[b] || 0)
                    },
                    min: function() {
                        return "" === e ? parseFloat(h[b] || 0) : Math.min(parseFloat(e), parseFloat(h[b] || 0))
                    },
                    max: function() {
                        return "" === e ? parseFloat(h[b] || 0) : Math.max(parseFloat(e), parseFloat(h[b] || 0))
                    },
                    count: function() {
                        "" === e && (e = 0);
                        return h.hasOwnProperty(b) ? e + 1 : 0
                    },
                    avg: function() {
                        return g.sum()
                    }
                };
                if (!g[a]) throw "jqGrid Grouping No such method: " + a;
                a = g[a]();
                null != f && ("fixed" === c ? a = a.toFixed(f) : (f = Math.pow(10, f), a = Math.round(a * f) / f));
                return a
            }
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.extend({
        jqGridImport: function(d) {
            d = a.extend({
                imptype: "xml",
                impstring: "",
                impurl: "",
                mtype: "GET",
                impData: {},
                xmlGrid: {
                    config: "roots>grid",
                    data: "roots>rows"
                },
                jsonGrid: {
                    config: "grid",
                    data: "data"
                },
                ajaxOptions: {}
            }, d || {});
            return this.each(function() {
                var e = this,
                    b = function(b, c) {
                        var d = a(c.xmlGrid.config, b)[0],
                            f = a(c.xmlGrid.data, b)[0],
                            k, m;
                        if (xmlJsonClass.xml2json && a.jgrid.parse) {
                            d = xmlJsonClass.xml2json(d, " ");
                            d = a.jgrid.parse(d);
                            for (m in d) d.hasOwnProperty(m) && (k = d[m]);
                            f ? (f = d.grid.datatype,
                                d.grid.datatype = "xmlstring", d.grid.datastr = b, a(e).jqGrid(k).jqGrid("setGridParam", {
                                    datatype: f
                                })) : a(e).jqGrid(k)
                        } else alert("xml2json or parse are not present")
                    },
                    f = function(b, c) {
                        if (b && "string" === typeof b) {
                            var d = !1;
                            a.jgrid.useJSON && (a.jgrid.useJSON = !1, d = !0);
                            var f = a.jgrid.parse(b);
                            d && (a.jgrid.useJSON = !0);
                            d = f[c.jsonGrid.config];
                            if (f = f[c.jsonGrid.data]) {
                                var k = d.datatype;
                                d.datatype = "jsonstring";
                                d.datastr = f;
                                a(e).jqGrid(d).jqGrid("setGridParam", {
                                    datatype: k
                                })
                            } else a(e).jqGrid(d)
                        }
                    };
                switch (d.imptype) {
                    case "xml":
                        a.ajax(a.extend({
                            url: d.impurl,
                            type: d.mtype,
                            data: d.impData,
                            dataType: "xml",
                            complete: function(c, f) {
                                "success" === f && (b(c.responseXML, d), a(e).triggerHandler("jqGridImportComplete", [c, d]), a.isFunction(d.importComplete) && d.importComplete(c))
                            }
                        }, d.ajaxOptions));
                        break;
                    case "xmlstring":
                        if (d.impstring && "string" === typeof d.impstring) {
                            var c = a.parseXML(d.impstring);
                            c && (b(c, d), a(e).triggerHandler("jqGridImportComplete", [c, d]), a.isFunction(d.importComplete) && d.importComplete(c), d.impstring = null);
                            c = null
                        }
                        break;
                    case "json":
                        a.ajax(a.extend({
                            url: d.impurl,
                            type: d.mtype,
                            data: d.impData,
                            dataType: "json",
                            complete: function(b) {
                                try {
                                    f(b.responseText, d), a(e).triggerHandler("jqGridImportComplete", [b, d]), a.isFunction(d.importComplete) && d.importComplete(b)
                                } catch (c) {}
                            }
                        }, d.ajaxOptions));
                        break;
                    case "jsonstring":
                        d.impstring && "string" === typeof d.impstring && (f(d.impstring, d), a(e).triggerHandler("jqGridImportComplete", [d.impstring, d]), a.isFunction(d.importComplete) && d.importComplete(d.impstring), d.impstring = null)
                }
            })
        },
        jqGridExport: function(d) {
            var d = a.extend({
                    exptype: "xmlstring",
                    root: "grid",
                    ident: "\t"
                }, d || {}),
                e = null;
            this.each(function() {
                if (this.grid) {
                    var b, f = a.extend(!0, {}, a(this).jqGrid("getGridParam"));
                    f.rownumbers && (f.colNames.splice(0, 1), f.colModel.splice(0, 1));
                    f.multiselect && (f.colNames.splice(0, 1), f.colModel.splice(0, 1));
                    f.subGrid && (f.colNames.splice(0, 1), f.colModel.splice(0, 1));
                    f.knv = null;
                    if (f.treeGrid)
                        for (b in f.treeReader) f.treeReader.hasOwnProperty(b) && (f.colNames.splice(f.colNames.length - 1), f.colModel.splice(f.colModel.length - 1));
                    switch (d.exptype) {
                        case "xmlstring":
                            e =
                                "<" + d.root + ">" + xmlJsonClass.json2xml(f, d.ident) + "</" + d.root + ">";
                            break;
                        case "jsonstring":
                            e = "{" + xmlJsonClass.toJson(f, d.root, d.ident, !1) + "}", void 0 !== f.postData.filters && (e = e.replace(/filters":"/, 'filters":'), e = e.replace(/}]}"/, "}]}"))
                    }
                }
            });
            return e
        },
        excelExport: function(d) {
            d = a.extend({
                exptype: "remote",
                url: null,
                oper: "oper",
                tag: "excel",
                exportOptions: {}
            }, d || {});
            return this.each(function() {
                if (this.grid) {
                    var e;
                    "remote" === d.exptype && (e = a.extend({}, this.p.postData), e[d.oper] = d.tag, e = jQuery.param(e), e = -1 !==
                        d.url.indexOf("?") ? d.url + "&" + e : d.url + "?" + e, window.location = e)
                }
            })
        }
    })
})(jQuery);
(function(a) {
    a.jgrid.msie && 8 === a.jgrid.msiever() && (a.expr[":"].hidden = function(a) {
        return 0 === a.offsetWidth || 0 === a.offsetHeight || "none" === a.style.display
    });
    a.jgrid._multiselect = !1;
    if (a.ui && a.ui.multiselect) {
        if (a.ui.multiselect.prototype._setSelected) {
            var d = a.ui.multiselect.prototype._setSelected;
            a.ui.multiselect.prototype._setSelected = function(e, b) {
                var f = d.call(this, e, b);
                if (b && this.selectedList) {
                    var c = this.element;
                    this.selectedList.find("li").each(function() {
                        a(this).data("optionLink") && a(this).data("optionLink").remove().appendTo(c)
                    })
                }
                return f
            }
        }
        a.ui.multiselect.prototype.destroy &&
            (a.ui.multiselect.prototype.destroy = function() {
                this.element.show();
                this.container.remove();
                a.Widget === void 0 ? a.widget.prototype.destroy.apply(this, arguments) : a.Widget.prototype.destroy.apply(this, arguments)
            });
        a.jgrid._multiselect = !0
    }
    a.jgrid.extend({
        sortableColumns: function(d) {
            return this.each(function() {
                function b() {
                    f.p.disableClick = true
                }
                var f = this,
                    c = a.jgrid.jqID(f.p.id),
                    c = {
                        tolerance: "pointer",
                        axis: "x",
                        scrollSensitivity: "1",
                        items: ">th:not(:has(#jqgh_" + c + "_cb,#jqgh_" + c + "_rn,#jqgh_" + c + "_subgrid),:hidden)",
                        placeholder: {
                            element: function(b) {
                                return a(document.createElement(b[0].nodeName)).addClass(b[0].className + " ui-sortable-placeholder ui-state-highlight").removeClass("ui-sortable-helper")[0]
                            },
                            update: function(a, b) {
                                b.height(a.currentItem.innerHeight() - parseInt(a.currentItem.css("paddingTop") || 0, 10) - parseInt(a.currentItem.css("paddingBottom") || 0, 10));
                                b.width(a.currentItem.innerWidth() - parseInt(a.currentItem.css("paddingLeft") || 0, 10) - parseInt(a.currentItem.css("paddingRight") || 0, 10))
                            }
                        },
                        update: function(b,
                            c) {
                            var d = a(c.item).parent(),
                                d = a(">th", d),
                                e = {},
                                h = f.p.id + "_";
                            a.each(f.p.colModel, function(a) {
                                e[this.name] = a
                            });
                            var o = [];
                            d.each(function() {
                                var b = a(">div", this).get(0).id.replace(/^jqgh_/, "").replace(h, "");
                                e.hasOwnProperty(b) && o.push(e[b])
                            });
                            a(f).jqGrid("remapColumns", o, true, true);
                            a.isFunction(f.p.sortable.update) && f.p.sortable.update(o);
                            setTimeout(function() {
                                f.p.disableClick = false
                            }, 50)
                        }
                    };
                if (f.p.sortable.options) a.extend(c, f.p.sortable.options);
                else if (a.isFunction(f.p.sortable)) f.p.sortable = {
                    update: f.p.sortable
                };
                if (c.start) {
                    var h = c.start;
                    c.start = function(a, c) {
                        b();
                        h.call(this, a, c)
                    }
                } else c.start = b; if (f.p.sortable.exclude) c.items = c.items + (":not(" + f.p.sortable.exclude + ")");
                d.sortable(c).data("sortable").floating = true
            })
        },
        columnChooser: function(d) {
            function b(b, c) {
                b && (typeof b === "string" ? a.fn[b] && a.fn[b].apply(c, a.makeArray(arguments).slice(2)) : a.isFunction(b) && b.apply(c, a.makeArray(arguments).slice(2)))
            }
            var f = this;
            if (!a("#colchooser_" + a.jgrid.jqID(f[0].p.id)).length) {
                var c = a('<div id="colchooser_' + f[0].p.id + '" style="position:relative;overflow:hidden"><div><select multiple="multiple"></select></div></div>'),
                    h = a("select", c),
                    d = a.extend({
                        width: 420,
                        height: 240,
                        classname: null,
                        done: function(a) {
                            a && f.jqGrid("remapColumns", a, true)
                        },
                        msel: "multiselect",
                        dlog: "dialog",
                        dialog_opts: {
                            minWidth: 470
                        },
                        dlog_opts: function(b) {
                            var c = {};
                            c[b.bSubmit] = function() {
                                b.apply_perm();
                                b.cleanup(false)
                            };
                            c[b.bCancel] = function() {
                                b.cleanup(true)
                            };
                            return a.extend(true, {
                                buttons: c,
                                close: function() {
                                    b.cleanup(true)
                                },
                                modal: b.modal || false,
                                resizable: b.resizable || true,
                                width: b.width + 20
                            }, b.dialog_opts || {})
                        },
                        apply_perm: function() {
                            a("option", h).each(function() {
                                this.selected ?
                                    f.jqGrid("showCol", g[this.value].name) : f.jqGrid("hideCol", g[this.value].name)
                            });
                            var b = [];
                            a("option:selected", h).each(function() {
                                b.push(parseInt(this.value, 10))
                            });
                            a.each(b, function() {
                                delete j[g[parseInt(this, 10)].name]
                            });
                            a.each(j, function() {
                                var a = parseInt(this, 10);
                                var c = b,
                                    d = a;
                                if (d >= 0) {
                                    var e = c.slice(),
                                        f = e.splice(d, Math.max(c.length - d, d));
                                    if (d > c.length) d = c.length;
                                    e[d] = a;
                                    b = e.concat(f)
                                } else b = void 0
                            });
                            d.done && d.done.call(f, b)
                        },
                        cleanup: function(a) {
                            b(d.dlog, c, "destroy");
                            b(d.msel, h, "destroy");
                            c.remove();
                            a && d.done && d.done.call(f)
                        },
                        msel_opts: {}
                    }, a.jgrid.col, d || {});
                if (a.ui && a.ui.multiselect && d.msel === "multiselect") {
                    if (!a.jgrid._multiselect) {
                        alert("Multiselect plugin loaded after jqGrid. Please load the plugin before the jqGrid!");
                        return
                    }
                    d.msel_opts = a.extend(a.ui.multiselect.defaults, d.msel_opts)
                }
                d.caption && c.attr("title", d.caption);
                if (d.classname) {
                    c.addClass(d.classname);
                    h.addClass(d.classname)
                }
                if (d.width) {
                    a(">div", c).css({
                        width: d.width,
                        margin: "0 auto"
                    });
                    h.css("width", d.width)
                }
                if (d.height) {
                    a(">div",
                        c).css("height", d.height);
                    h.css("height", d.height - 10)
                }
                var g = f.jqGrid("getGridParam", "colModel"),
                    i = f.jqGrid("getGridParam", "colNames"),
                    j = {},
                    k = [];
                h.empty();
                a.each(g, function(b) {
                    j[this.name] = b;
                    this.hidedlg ? this.hidden || k.push(b) : h.append("<option value='" + b + "' " + (this.hidden ? "" : "selected='selected'") + ">" + a.jgrid.stripHtml(i[b]) + "</option>")
                });
                var m = a.isFunction(d.dlog_opts) ? d.dlog_opts.call(f, d) : d.dlog_opts;
                b(d.dlog, c, m);
                m = a.isFunction(d.msel_opts) ? d.msel_opts.call(f, d) : d.msel_opts;
                b(d.msel, h, m)
            }
        },
        sortableRows: function(d) {
            return this.each(function() {
                var b =
                    this;
                if (b.grid && !b.p.treeGrid && a.fn.sortable) {
                    d = a.extend({
                        cursor: "move",
                        axis: "y",
                        items: ".jqgrow"
                    }, d || {});
                    if (d.start && a.isFunction(d.start)) {
                        d._start_ = d.start;
                        delete d.start
                    } else d._start_ = false; if (d.update && a.isFunction(d.update)) {
                        d._update_ = d.update;
                        delete d.update
                    } else d._update_ = false;
                    d.start = function(f, c) {
                        a(c.item).css("border-width", "0");
                        a("td", c.item).each(function(a) {
                            this.style.width = b.grid.cols[a].style.width
                        });
                        if (b.p.subGrid) {
                            var h = a(c.item).attr("id");
                            try {
                                a(b).jqGrid("collapseSubGridRow",
                                    h)
                            } catch (g) {}
                        }
                        d._start_ && d._start_.apply(this, [f, c])
                    };
                    d.update = function(f, c) {
                        a(c.item).css("border-width", "");
                        b.p.rownumbers === true && a("td.jqgrid-rownum", b.rows).each(function(c) {
                            a(this).html(c + 1 + (parseInt(b.p.page, 10) - 1) * parseInt(b.p.rowNum, 10))
                        });
                        d._update_ && d._update_.apply(this, [f, c])
                    };
                    a("tbody:first", b).sortable(d);
                    a("tbody:first", b).disableSelection()
                }
            })
        },
        gridDnD: function(d) {
            return this.each(function() {
                function b() {
                    var b = a.data(f, "dnd");
                    a("tr.jqgrow:not(.ui-draggable)", f).draggable(a.isFunction(b.drag) ?
                        b.drag.call(a(f), b) : b.drag)
                }
                var f = this,
                    c, h;
                if (f.grid && !f.p.treeGrid && a.fn.draggable && a.fn.droppable) {
                    a("#jqgrid_dnd")[0] === void 0 && a("body").append("<table id='jqgrid_dnd' class='ui-jqgrid-dnd'></table>");
                    if (typeof d === "string" && d === "updateDnD" && f.p.jqgdnd === true) b();
                    else {
                        d = a.extend({
                                drag: function(b) {
                                    return a.extend({
                                        start: function(c, d) {
                                            var e;
                                            if (f.p.subGrid) {
                                                e = a(d.helper).attr("id");
                                                try {
                                                    a(f).jqGrid("collapseSubGridRow", e)
                                                } catch (h) {}
                                            }
                                            for (e = 0; e < a.data(f, "dnd").connectWith.length; e++) a(a.data(f, "dnd").connectWith[e]).jqGrid("getGridParam",
                                                "reccount") === 0 && a(a.data(f, "dnd").connectWith[e]).jqGrid("addRowData", "jqg_empty_row", {});
                                            d.helper.addClass("ui-state-highlight");
                                            a("td", d.helper).each(function(a) {
                                                this.style.width = f.grid.headers[a].width + "px"
                                            });
                                            b.onstart && a.isFunction(b.onstart) && b.onstart.call(a(f), c, d)
                                        },
                                        stop: function(c, d) {
                                            var e;
                                            if (d.helper.dropped && !b.dragcopy) {
                                                e = a(d.helper).attr("id");
                                                e === void 0 && (e = a(this).attr("id"));
                                                a(f).jqGrid("delRowData", e)
                                            }
                                            for (e = 0; e < a.data(f, "dnd").connectWith.length; e++) a(a.data(f, "dnd").connectWith[e]).jqGrid("delRowData",
                                                "jqg_empty_row");
                                            b.onstop && a.isFunction(b.onstop) && b.onstop.call(a(f), c, d)
                                        }
                                    }, b.drag_opts || {})
                                },
                                drop: function(b) {
                                    return a.extend({
                                        accept: function(b) {
                                            if (!a(b).hasClass("jqgrow")) return b;
                                            b = a(b).closest("table.ui-jqgrid-btable");
                                            if (b.length > 0 && a.data(b[0], "dnd") !== void 0) {
                                                b = a.data(b[0], "dnd").connectWith;
                                                return a.inArray("#" + a.jgrid.jqID(this.id), b) !== -1 ? true : false
                                            }
                                            return false
                                        },
                                        drop: function(c, d) {
                                            if (a(d.draggable).hasClass("jqgrow")) {
                                                var e = a(d.draggable).attr("id"),
                                                    e = d.draggable.parent().parent().jqGrid("getRowData",
                                                        e);
                                                if (!b.dropbyname) {
                                                    var h = 0,
                                                        o = {},
                                                        n, l, p = a("#" + a.jgrid.jqID(this.id)).jqGrid("getGridParam", "colModel");
                                                    try {
                                                        for (l in e)
                                                            if (e.hasOwnProperty(l)) {
                                                                n = p[h].name;
                                                                n === "cb" || (n === "rn" || n === "subgrid") || e.hasOwnProperty(l) && p[h] && (o[n] = e[l]);
                                                                h++
                                                            }
                                                        e = o
                                                    } catch (r) {}
                                                }
                                                d.helper.dropped = true;
                                                if (b.beforedrop && a.isFunction(b.beforedrop)) {
                                                    n = b.beforedrop.call(this, c, d, e, a("#" + a.jgrid.jqID(f.p.id)), a(this));
                                                    n !== void 0 && (n !== null && typeof n === "object") && (e = n)
                                                }
                                                if (d.helper.dropped) {
                                                    var q;
                                                    if (b.autoid)
                                                        if (a.isFunction(b.autoid)) q =
                                                            b.autoid.call(this, e);
                                                        else {
                                                            q = Math.ceil(Math.random() * 1E3);
                                                            q = b.autoidprefix + q
                                                        }
                                                    a("#" + a.jgrid.jqID(this.id)).jqGrid("addRowData", q, e, b.droppos)
                                                }
                                                b.ondrop && a.isFunction(b.ondrop) && b.ondrop.call(this, c, d, e)
                                            }
                                        }
                                    }, b.drop_opts || {})
                                },
                                onstart: null,
                                onstop: null,
                                beforedrop: null,
                                ondrop: null,
                                drop_opts: {
                                    activeClass: "ui-state-active",
                                    hoverClass: "ui-state-hover"
                                },
                                drag_opts: {
                                    revert: "invalid",
                                    helper: "clone",
                                    cursor: "move",
                                    appendTo: "#jqgrid_dnd",
                                    zIndex: 5E3
                                },
                                dragcopy: false,
                                dropbyname: false,
                                droppos: "first",
                                autoid: true,
                                autoidprefix: "dnd_"
                            },
                            d || {});
                        if (d.connectWith) {
                            d.connectWith = d.connectWith.split(",");
                            d.connectWith = a.map(d.connectWith, function(b) {
                                return a.trim(b)
                            });
                            a.data(f, "dnd", d);
                            f.p.reccount !== 0 && !f.p.jqgdnd && b();
                            f.p.jqgdnd = true;
                            for (c = 0; c < d.connectWith.length; c++) {
                                h = d.connectWith[c];
                                a(h).droppable(a.isFunction(d.drop) ? d.drop.call(a(f), d) : d.drop)
                            }
                        }
                    }
                }
            })
        },
        gridResize: function(d) {
            return this.each(function() {
                var b = this,
                    f = a.jgrid.jqID(b.p.id);
                if (b.grid && a.fn.resizable) {
                    d = a.extend({}, d || {});
                    if (d.alsoResize) {
                        d._alsoResize_ = d.alsoResize;
                        delete d.alsoResize
                    } else d._alsoResize_ = false; if (d.stop && a.isFunction(d.stop)) {
                        d._stop_ = d.stop;
                        delete d.stop
                    } else d._stop_ = false;
                    d.stop = function(c, h) {
                        a(b).jqGrid("setGridParam", {
                            height: a("#gview_" + f + " .ui-jqgrid-bdiv").height()
                        });
                        a(b).jqGrid("setGridWidth", h.size.width, d.shrinkToFit);
                        d._stop_ && d._stop_.call(b, c, h)
                    };
                    d.alsoResize = d._alsoResize_ ? eval("(" + ("{'#gview_" + f + " .ui-jqgrid-bdiv':true,'" + d._alsoResize_ + "':true}") + ")") : a(".ui-jqgrid-bdiv", "#gview_" + f);
                    delete d._alsoResize_;
                    a("#gbox_" + f).resizable(d)
                }
            })
        }
    })
})(jQuery);

function tableToGrid(a, d) {
        jQuery(a).each(function() {
            if (!this.grid) {
                jQuery(this).width("99%");
                var a = jQuery(this).width(),
                    b = jQuery("tr td:first-child input[type=checkbox]:first", jQuery(this)),
                    f = jQuery("tr td:first-child input[type=radio]:first", jQuery(this)),
                    b = 0 < b.length,
                    f = !b && 0 < f.length,
                    c = b || f,
                    h = [],
                    g = [];
                jQuery("th", jQuery(this)).each(function() {
                    0 === h.length && c ? (h.push({
                        name: "__selection__",
                        index: "__selection__",
                        width: 0,
                        hidden: !0
                    }), g.push("__selection__")) : (h.push({
                        name: jQuery(this).attr("id") || jQuery.trim(jQuery.jgrid.stripHtml(jQuery(this).html())).split(" ").join("_"),
                        index: jQuery(this).attr("id") || jQuery.trim(jQuery.jgrid.stripHtml(jQuery(this).html())).split(" ").join("_"),
                        width: jQuery(this).width() || 150
                    }), g.push(jQuery(this).html()))
                });
                var i = [],
                    j = [],
                    k = [];
                jQuery("tbody > tr", jQuery(this)).each(function() {
                    var a = {},
                        b = 0;
                    jQuery("td", jQuery(this)).each(function() {
                        if (0 === b && c) {
                            var d = jQuery("input", jQuery(this)),
                                e = d.attr("value");
                            j.push(e || i.length);
                            d.is(":checked") && k.push(e);
                            a[h[b].name] = d.attr("value")
                        } else a[h[b].name] = jQuery(this).html();
                        b++
                    });
                    0 < b && i.push(a)
                });
                jQuery(this).empty();
                jQuery(this).addClass("scroll");
                jQuery(this).jqGrid(jQuery.extend({
                    datatype: "local",
                    width: a,
                    colNames: g,
                    colModel: h,
                    multiselect: b
                }, d || {}));
                for (a = 0; a < i.length; a++) f = null, 0 < j.length && (f = j[a]) && f.replace && (f = encodeURIComponent(f).replace(/[.\-%]/g, "_")), null === f && (f = a + 1), jQuery(this).jqGrid("addRowData", f, i[a]);
                for (a = 0; a < k.length; a++) jQuery(this).jqGrid("setSelection", k[a])
            }
        })
    }
    (function(a) {
        function d(a, b) {
            var d, c, h = [],
                g;
            if (!this || "function" !== typeof a || a instanceof RegExp) throw new TypeError;
            g = this.length;
            for (d = 0; d < g; d++)
                if (this.hasOwnProperty(d) && (c = this[d], a.call(b, c, d, this))) {
                    h.push(c);
                    break
                }
            return h
        }
        a.assocArraySize = function(a) {
            var b = 0,
                d;
            for (d in a) a.hasOwnProperty(d) && b++;
            return b
        };
        a.jgrid.extend({
            pivotSetup: function(e, b) {
                var f = [],
                    c = [],
                    h = [],
                    g = [],
                    i = {
                        grouping: !0,
                        groupingView: {
                            groupField: [],
                            groupSummary: [],
                            groupSummaryPos: []
                        }
                    },
                    j = [],
                    k = a.extend({
                        rowTotals: !1,
                        rowTotalsText: "Total",
                        colTotals: !1,
                        groupSummary: !0,
                        groupSummaryPos: "header",
                        frozenStaticCols: !1
                    }, b || {});
                this.each(function() {
                    function b(a, c, e) {
                        a = d.call(a, c, e);
                        return 0 < a.length ? a[0] : null
                    }

                    function o(a, b) {
                        var c = 0,
                            d = !0,
                            e;
                        for (e in a) {
                            if (a[e] != this[c]) {
                                d = !1;
                                break
                            }
                            c++;
                            if (c >= this.length) break
                        }
                        d && (r = b);
                        return d
                    }

                    function n(b, c, d, e) {
                        var f = c.length,
                            h, i, j, k;
                        k = a.isArray(d) ? d.length : 1;
                        g = [];
                        for (j = g.root = 0; j < k; j++) {
                            var l = [],
                                m;
                            for (h = 0; h < f; h++) {
                                if (null == d) m = i = a.trim(c[h].member) + "_" + c[h].aggregator;
                                else {
                                    m = d[j].replace(/\s+/g, "");
                                    try {
                                        i =
                                            1 === f ? m : m + "_" + c[h].aggregator + "_" + h
                                    } catch (n) {}
                                }
                                i = !isNaN(parseInt(i, 10)) ? i + " " : i;
                                var o = e,
                                    p = i,
                                    q = l,
                                    r = i,
                                    s = e[i],
                                    t = c[h].member,
                                    u = b,
                                    v = void 0;
                                switch (c[h].aggregator) {
                                    case "sum":
                                        v = parseFloat(s || 0) + parseFloat(u[t] || 0);
                                        break;
                                    case "count":
                                        if ("" === s || null == s) s = 0;
                                        v = u.hasOwnProperty(t) ? s + 1 : 0;
                                        break;
                                    case "min":
                                        v = "" === s || null == s ? parseFloat(u[t] || 0) : Math.min(parseFloat(s), parseFloat(u[t] || 0));
                                        break;
                                    case "max":
                                        v = "" === s || null == s ? parseFloat(u[t] || 0) : Math.max(parseFloat(s), parseFloat(u[t] || 0))
                                }
                                o[p] = q[r] = v
                            }
                            m = !isNaN(parseInt(m,
                                10)) ? m + " " : m;
                            g[m] = l
                        }
                        return e
                    }

                    function l(a) {
                        var b, c, d, e, g;
                        for (d in a)
                            if (a.hasOwnProperty(d)) {
                                if ("object" !== typeof a[d] && ("level" === d && (void 0 === O[a.level] && (O[a.level] = "", 0 < a.level && "_r_Totals" !== a.text && (j[a.level - 1] = {
                                    useColSpanStyle: !1,
                                    groupHeaders: []
                                })), O[a.level] !== a.text && (a.children.length && "_r_Totals" !== a.text) && 0 < a.level && (j[a.level - 1].groupHeaders.push({
                                    titleText: a.text
                                }), c = j[a.level - 1].groupHeaders.length, g = 1 === c ? U : N + (c - 1) * v, j[a.level - 1].groupHeaders[c - 1].startColumnName = f[g].name, j[a.level -
                                    1].groupHeaders[c - 1].numberOfColumns = f.length - g, N = f.length), O[a.level] = a.text), a.level === w && "level" === d && 0 < w))
                                    if (1 < v) {
                                        c = 1;
                                        for (b in a.fields) 1 === c && j[w - 1].groupHeaders.push({
                                            startColumnName: b,
                                            numberOfColumns: 1,
                                            titleText: a.text
                                        }), c++;
                                        j[w - 1].groupHeaders[j[w - 1].groupHeaders.length - 1].numberOfColumns = c - 1
                                    } else j.splice(w - 1, 1);
                                null != a[d] && "object" === typeof a[d] && l(a[d]);
                                if ("level" === d && 0 < a.level)
                                    for (b in c = 0, a.fields) {
                                        g = {};
                                        for (e in k.aggregates[c])
                                            if (k.aggregates[c].hasOwnProperty(e)) switch (e) {
                                                case "member":
                                                case "label":
                                                case "aggregator":
                                                    break;
                                                default:
                                                    g[e] = k.aggregates[c][e]
                                            }
                                            1 < v ? (g.name = b, g.label = k.aggregates[c].label || b) : (g.name = a.text, g.label = "_r_Totals" === a.text ? k.rowTotalsText : a.text);
                                        f.push(g);
                                        c++
                                    }
                            }
                    }
                    var p, r, q, s = e.length,
                        t, w, v, x, H = 0;
                    k.rowTotals && 0 < k.yDimension.length && (k.yDimension.splice(0, 0, {
                        dataName: k.yDimension[0].dataName
                    }), k.yDimension[0].converter = function() {
                        return "_r_Totals"
                    });
                    t = a.isArray(k.xDimension) ? k.xDimension.length : 0;
                    w = k.yDimension.length;
                    v = a.isArray(k.aggregates) ? k.aggregates.length : 0;
                    if (0 === t || 0 === v) throw "xDimension or aggregates optiona are not set!";
                    var y;
                    for (q = 0; q < t; q++) y = {
                        name: k.xDimension[q].dataName,
                        frozen: k.frozenStaticCols
                    }, null == k.xDimension[q].isGroupField && (k.xDimension[q].isGroupField = !0), y = a.extend(!0, y, k.xDimension[q]), f.push(y);
                    y = t - 1;
                    for (var D = {}; H < s;) {
                        p = e[H];
                        var z = [],
                            u = [];
                        x = {};
                        q = 0;
                        do z[q] = a.trim(p[k.xDimension[q].dataName]), x[k.xDimension[q].dataName] = z[q], q++; while (q < t);
                        var A = 0;
                        r = -1;
                        if (q = b(c, o, z)) {
                            if (0 <= r) {
                                A = 0;
                                if (1 <= w) {
                                    for (A = 0; A < w; A++) u[A] = a.trim(p[k.yDimension[A].dataName]), k.yDimension[A].converter && a.isFunction(k.yDimension[A].converter) &&
                                        (u[A] = k.yDimension[A].converter.call(this, u[A], z, u));
                                    q = n(p, k.aggregates, u, q)
                                } else 0 === w && (q = n(p, k.aggregates, null, q));
                                c[r] = q
                            }
                        } else {
                            A = 0;
                            if (1 <= w) {
                                for (A = 0; A < w; A++) u[A] = a.trim(p[k.yDimension[A].dataName]), k.yDimension[A].converter && a.isFunction(k.yDimension[A].converter) && (u[A] = k.yDimension[A].converter.call(this, u[A], z, u));
                                x = n(p, k.aggregates, u, x)
                            } else 0 === w && (x = n(p, k.aggregates, null, x));
                            c.push(x)
                        }
                        p = 0;
                        var z = x = null,
                            B;
                        for (B in g) {
                            if (0 === p) {
                                if (!D.children || void 0 === D.children) D = {
                                    text: B,
                                    level: 0,
                                    children: []
                                };
                                x = D.children
                            } else {
                                z = null;
                                for (q = 0; q < x.length; q++)
                                    if (x[q].text === B) {
                                        z = x[q];
                                        break
                                    }
                                z ? x = z.children : (x.push({
                                    children: [],
                                    text: B,
                                    level: p,
                                    fields: g[B]
                                }), x = x[x.length - 1].children)
                            }
                            p++
                        }
                        H++
                    }
                    var O = [],
                        N = f.length,
                        U = N;
                    0 < w && (j[w - 1] = {
                        useColSpanStyle: !1,
                        groupHeaders: []
                    });
                    l(D, 0);
                    if (k.colTotals)
                        for (H = c.length; H--;)
                            for (q = t; q < f.length; q++) s = f[q].name, h[s] = h[s] ? h[s] + parseFloat(c[H][s] || 0) : parseFloat(c[H][s] || 0);
                    if (0 < y)
                        for (q = 0; q < y; q++) f[q].isGroupField && (i.groupingView.groupField.push(f[q].name), i.groupingView.groupSummary.push(k.groupSummary),
                            i.groupingView.groupSummaryPos.push(k.groupSummaryPos));
                    else i.grouping = !1;
                    i.sortname = f[y].name;
                    i.groupingView.hideFirstGroupCol = !0
                });
                return {
                    colModel: f,
                    rows: c,
                    groupOptions: i,
                    groupHeaders: j,
                    summary: h
                }
            },
            jqPivot: function(d, b, f, c) {
                return this.each(function() {
                    function h(c) {
                        for (var d = jQuery(g).jqGrid("pivotSetup", c, b), e = 0 < a.assocArraySize(d.summary) ? !0 : !1, h = a.jgrid.from(d.rows), c = 0; c < d.groupOptions.groupingView.groupField.length; c++) h.orderBy(d.groupOptions.groupingView.groupField[c], "a", "text", "");
                        jQuery(g).jqGrid(a.extend(!0, {
                            datastr: a.extend(h.select(), e ? {
                                userdata: d.summary
                            } : {}),
                            datatype: "jsonstring",
                            footerrow: e,
                            userDataOnFooter: e,
                            colModel: d.colModel,
                            viewrecords: !0,
                            sortname: b.xDimension[0].dataName
                        }, d.groupOptions, f || {}));
                        d = d.groupHeaders;
                        if (d.length)
                            for (c = 0; c < d.length; c++) d[c] && d[c].groupHeaders.length && jQuery(g).jqGrid("setGroupHeaders", d[c]);
                        b.frozenStaticCols && jQuery(g).jqGrid("setFrozenColumns")
                    }
                    var g = this;
                    "string" === typeof d ? a.ajax(a.extend({
                        url: d,
                        dataType: "json",
                        success: function(b) {
                            h(a.jgrid.getAccessor(b, c &&
                                c.reader ? c.reader : "rows"))
                        }
                    }, c || {})) : h(d)
                })
            }
        })
    })(jQuery);