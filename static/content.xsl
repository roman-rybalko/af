<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="content">
		<tr><td>
		<xsl:if test="@title">
			<span style="background-color:#d7e6fb;">
				<xsl:value-of select="@title"/>
			</span>
		</xsl:if>
		<xsl:if test="@titlelink">
			<img src="{@titlelink}" align="left"/>
		</xsl:if>
		<p>
		<xsl:apply-templates select="image"/>
		<xsl:value-of select="text"/>
		<xsl:apply-templates select="section"/>
		<xsl:apply-templates select="link"/>
		</p>
		</td></tr>
	</xsl:template>

	<xsl:template match="content/image">
		<img src="{@link}" align="left"/>
	</xsl:template>

	<xsl:template match="content/link">
		<a href="{@link}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>

	<xsl:template match="content/section">
		<table>
		<tr>
			<td>
				<xsl:apply-templates select="image"/>
			</td>
			<td>
			<table>
				<tr>
					<td>
						<xsl:if test="@title">
							<span style="background-color:#eaf0fc;">
								<xsl:value-of select="@title"/>
							</span>
						</xsl:if>
						<xsl:if test="@titlelink">
							<img src="{@titlelink}" align="center"/>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:value-of select="text"/>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		</table>
	</xsl:template>

	<xsl:template match="section/image">
		<img src="{@link}" align="left"/>
	</xsl:template>

</xsl:stylesheet>