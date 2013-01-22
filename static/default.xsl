<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">

	<xsl:include href="menu.xsl" />
	<xsl:include href="content.xsl" />

	<xsl:template match="root">
		<html>
			<head>
				<title>
					<xsl:value-of select="$locale_title" />
				</title>
			</head>
			<body>
				<xsl:apply-templates select="menu" />
				<xsl:apply-templates select="content" />
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
