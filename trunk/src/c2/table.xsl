<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"> 

	<xsl:output method="html" indent="yes" />
	
	<xsl:template match="list">
		<table id="dataTable">
			<tbody>
				<xsl:apply-templates select="item" />
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="item">
		<tr>
			<td><xsl:value-of select="itemId" /></td>
			<td><xsl:value-of select="age" /></td>
			<td><xsl:value-of select="classOfWorker" /></td>
			<td><xsl:value-of select="education" /></td>
			<td><xsl:value-of select="maritalStatus" /></td>
			<td><xsl:value-of select="race" /></td>
			<td><xsl:value-of select="sex" /></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
