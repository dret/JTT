<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  <xsl:output method="text" />
  <xsl:template match="data-types">
    <xsl:result-document href="overview.md">
      <xsl:text># Data Types&#xa;&#xa;</xsl:text>
      <xsl:text>A collection of existing data types to be used in JTT.&#xa;&#xa;&#xa;</xsl:text>
      <xsl:text>## Well-Known Values&#xa;</xsl:text>
      <xsl:text>-----------------&#xa;&#xa;</xsl:text>
      <xsl:text>| Value | Description | Source |&#xa;</xsl:text>
      <xsl:text>| ----- | ----------- | ------ |&#xa;</xsl:text>
      <xsl:for-each select="data-type">
        <xsl:sort select="@id"/>
        <xsl:value-of select="concat('| `', @id, '` | ', text(), ' | ', //spec[@id eq current()/@src]/title, ' |&#xa;')"/>
      </xsl:for-each>
      <xsl:text>&#xa;&#xa;## References&#xa;&#xa;</xsl:text>
      <xsl:for-each select="spec">
        <xsl:sort select="title"/>
        <xsl:value-of select="concat(position(), '. [', title/text(), '](', @href, ')')"/>
        <xsl:if test="exists(desc)">
          <xsl:text>: </xsl:text>
          <xsl:value-of select="desc/text()"/>
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
