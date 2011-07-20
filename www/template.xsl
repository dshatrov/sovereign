<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY bull "&#160;">
<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:exslt="http://exslt.org/common"
		extension-element-prefixes="exslt">

<xsl:output method="xml"
	    version="1.0"
	    encoding="UTF-8"
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<xsl:template match="sovereign">

<html>
<head>
	<title>Sovereign</title>
	<link rel="stylesheet" type="text/css" href="sovereign.css"/>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td style="width: 1px; height: 1px">
				<div style="height: 10px; width: 10px"></div>
			</td>
			<td class="hbar" style="width: 1px; height: 1px">
				<div style="width: 10px"></div>
			</td>
			<td class="hbar" style="width: 1px; height: 1px">
				<div style="width: 90px"></div>
			</td>
			<td class="hbar" style="width: 1px; height: 1px">
				<div style="width: 10px"></div>
			</td>
			<td style="width: 1px; height: 1px"/>
		</tr>
		<tr>
			<td style="width: 1px; height: 1px"/>
			<td class="hbar" style="width: 1px; height: 1px"/>
			<td class="hbar" style="width: 1px; height: 1px; vertical-align: top">
				<div class="border-right" style="height: 15px; margin-top: 0px; margin-bottom: 0px"></div>

<!-- MENU BEGIN -->
<div style="position: absolute; left: 5px; width: 120px">
<table class="hbar menu" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="border-top border-left border-right border-bottom">
			<div class="nonlast" style="background-color: #ffffff">
				<xsl:choose>
					<xsl:when test="name = 'readme_eng'">
						<span class="this" style="text-align: center">
							<a href="index.html">
								<tt><b>English</b></tt>
							</a>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span style="text-align: center">
							<a href="index.html">
								<tt><b>English</b></tt>
							</a>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</div>
			<div class="last" style="padding-top: 0px; background-color: #ffffff">
				<xsl:choose>
					<xsl:when test="name = 'readme_rus'">
						<span class="this" style="text-align: center">
							<a href="readme_rus.html">
								<tt><b>Русский</b></tt>
							</a>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<span style="text-align: center">
							<a href="readme_rus.html">
								<tt><b>Русский</b></tt>
							</a>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</td>
	</tr>
</table>
</div>
<!-- MENU END -->

				<div style="margin-top: 4px; margin-bottom: 4px">&nbsp;</div>
			</td>
			<td class="hbar border-top" style="width: 1px; height: 1px"/>
			<td rowspan="1" class="border-top" style="width: 100%; background-color: #ffffff; padding: 15px; vertical-align: top">

<!-- CONTENT BEGIN -->
<xsl:copy-of select="content/*"/>
<div style="height: 100px"></div>
<!-- CONTENT END -->

			</td>
		</tr>
		<tr>
			<td style="width: 1px; height: 1px"/>
			<td style="width: 1px; height: 1px"/>
			<td class="sfbutton" style="width: 1px; height: 1px; text-align: center">
				<div style="margin-top: 3px; margin-bottom: 3px">
					<a href="http://sourceforge.net"><img src="http://sflogo.sourceforge.net/sflogo.php?group_id=213114&amp;type=1" width="88" height="31" border="0" alt="SourceForge.net Logo" /></a>
				</div>
			</td>
			<td style="width: 1px; height: 1px"/>
			<td style="width: 1px; height: 1px"/>
		</tr>
		<tr>
			<td style="width: 1px; height: 1px">
				<div style="height: 100px"></div>
			</td>
			<td class="hbar" style="width: 1px; height: 1px"/>
			<td class="hbar" style="width: 1px; height: 1px"/>
			<td class="hbar" style="width: 1px; height: 1px"/>
			<td style="width: 1px; height: 1px"/>
		</tr>
	</tbody>
</table>
</body>
</html>
</xsl:template>

</xsl:stylesheet>

