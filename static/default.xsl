<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>

	<xsl:include href="menu.xsl"/>
	<xsl:include href="content.xsl"/>

	<xsl:template match="root">
		<html>
			<head>
				<title>
					<xsl:value-of select="title"/>
				</title>
			</head>
			<body>
				<xsl:apply-templates select="logo"/>
				<xsl:apply-templates select="topmenu"/>
				<xsl:apply-templates select="menu"/>
				<table>
				<xsl:apply-templates select="content"/>
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="root/logo[lang='ru']">
		<img src="static/logo_ru.jpg" align="left"/>
	</xsl:template>

</xsl:stylesheet>
