<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="content">
		<div class="row">
			<div class="span12">
				<xsl:apply-templates select="title"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="table"/>
				<xsl:apply-templates select="section"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="form"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="content/content">
		<div class="row-fluid">
			<div class="span12">
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="table"/>
				<xsl:apply-templates select="title"/>
				<xsl:apply-templates select="section"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="form"/>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="content/title">
		<legend class="af-title">
			<xsl:apply-templates select="text"/>
		</legend>
	</xsl:template>

	<xsl:template match="content/title[@link]">
		<img src="{@link}"/>
	</xsl:template>


	<xsl:template match="image">
		<img src="{@link}" class="af-image-centered"/>
	</xsl:template>

	<xsl:variable name="image_common">
		<script type="text/javascript">
			function reformatImages()
			{
				$(".af-image-floated").each(function() {
					if ($(this).width() / $(this).parent().width() &gt; 0.6) {
						$(this).removeClass("af-image-floated");
						$(this).addClass("af-image-centered");
					}
				});
				$(".af-image-centered").each(function() {
					if ($(this).width() / $(this).parent().width() &lt;= 0.6) {
						$(this).removeClass("af-image-centered");
						$(this).addClass("af-image-floated");
					}
				});
			}

			$(window).load(reformatImages);
			$(window).resize(reformatImages);
		</script>
	</xsl:variable>


	<xsl:template match="table">
		<xsl:apply-templates select="title"/>
		<table class="table table-hover">
			<xsl:if test="head">
				<thead>
					<xsl:apply-templates select="head"/>
				</thead>
			</xsl:if>
			<xsl:if test="row">
				<tbody>
					<xsl:apply-templates select="row"/>
				</tbody>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template match="table/title">
		<div class="af-title">
			<xsl:apply-templates select="text"/>
		</div>
	</xsl:template>

	<xsl:template match="table/head | table/row">
		<tr>
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>

	<xsl:template match="table/head/cell">
		<th>
			<xsl:apply-templates select="text"/>
		</th>
	</xsl:template>
	
	<xsl:template match="table/row/cell">
		<td>
			<xsl:apply-templates select="text"/>
		</td>
	</xsl:template>


	<xsl:template match="redirect">
		<div class="af-redirect">
			<a href="{@link}" class="btn btn-large btn-success">
				<xsl:apply-templates select="text"/>
			</a>
		</div>
		<xsl:if test="@force">
			<script type="text/javascript">
				document.location = "<xsl:value-of select="@link"/>";
			</script>
		</xsl:if>
	</xsl:template>

	
	<xsl:template match="section">
		<p class="af-section">
			<xsl:apply-templates select="text"/>
		</p>
	</xsl:template>

	<xsl:template match="text">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="text[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
	</xsl:template>
	
</xsl:stylesheet>