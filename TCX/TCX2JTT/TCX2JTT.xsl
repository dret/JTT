<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" exclude-result-prefixes="xs" version="3.0" xmlns:my="tag:xslt-can-be-weird">
  <xsl:output method="text" />
  
  
  <xsl:function name="my:indent">
    <xsl:param name="indent"/>
    <xsl:value-of select="for $i in 1 to $indent return ' '"/>
  </xsl:function>

</xsl:stylesheet>
