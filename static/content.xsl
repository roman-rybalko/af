<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="locale.xsl" />

	<xsl:template match="content[@name='description']">
		<xsl:value-of select="$locale_description" />
	</xsl:template>

</xsl:stylesheet>