<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 
  <xsl:output name="toc-format" method="xhtml" indent="yes"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
  
  <xsl:output name="section-format" method="xhtml" indent="no"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
    
  <xsl:template match="/">
    <xsl:result-document href="toc.html" format="toc-format" validation="lax">
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>Cookbook Table of Contents</title>
          <link rel="stylesheet"  type="text/css" href="style.css"/></head>
        <body>
     <!--    <div> <span> <xsl:value-of select="//recipe/@title"/></span>  </div> -->
          <div class="main">
			<h1>Cookbook</h1>
            <h2>Table of Contents</h2>
            <!-- Output a link for each SECTION. -->
            <ul>
              <xsl:for-each select="cookbook/recipe">
                <li><a><xsl:attribute name="href">recipe<xsl:value-of select="position()"/>.html</xsl:attribute>
                  <xsl:value-of select="title"/></a>
                </li>
              </xsl:for-each>
            </ul></div>
        </body>
      </html>
    </xsl:result-document>
    
    <!-- We need a separate  html page for each SECTION, 
      so we need a way to number the HTML pages. 
      The template below starts with a  variable for naming 
      the HTML pages. The variable will produce HTML pages that 
      use the number of the position of the SECTION element. 
      So the first SECTION element will be named section1.html, 
      the second SECTION element is named section2.html, etc. 
      You could use either ways of naming your 
      output files (title, id, etc.) but this way 
      works quite well.

--> 
    <xsl:for-each select="cookbook/recipe">
      <xsl:variable name="recipenumber" select="concat('recipe',position(),'.html')"/>
      
      <xsl:result-document format="section-format" validation="lax" href="{$recipenumber}" >
       
        <html xmlns="http://www.w3.org/1999/xhtml">
          <head>
            <title><xsl:value-of select="description"/></title>
            <link href="style.css" rel="stylesheet" type="text/css"/>
          </head>
          <body>
            <div>
             <xsl:apply-templates/> 
            </div>
          </body>
        </html>        
  
        
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
  
    <xsl:template match="title">
    <h2><xsl:value-of select="."/></h2>
     </xsl:template>
  
  <xsl:template match="GRAPHIC">
    <xsl:element name="img">
      <xsl:attribute name="src">
        <xsl:value-of select="@url"/>
      </xsl:attribute>
      <xsl:attribute name="alt">
        Picture: <xsl:value-of select="@url"/>
      </xsl:attribute>   
    </xsl:element>
  </xsl:template> 
  
    <xsl:template match="course">
    <h3>Course:<xsl:text> </xsl:text><xsl:value-of select="."/></h3>
  </xsl:template>
  
  <xsl:template match="cuisine">
    <h3>Cuisine:<xsl:text> </xsl:text><xsl:value-of select="./@type"/></h3>
  </xsl:template>
  
  <xsl:template match="ingredients">
    <div class="list">
    <xsl:for-each select="ingredient">
    <xsl:choose>
      <xsl:when test="amount">
       <li>
          <xsl:if test="amount!='*'">
            <xsl:value-of select="amount"/>
            <xsl:text> </xsl:text>
            <xsl:if test="unit">
              <xsl:value-of select="unit"/>
              <xsl:if test="number(amount)>number(1)">
                <xsl:text>s</xsl:text>
              </xsl:if>
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:value-of select="name"/>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li><xsl:value-of select="name"/></li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
  </div>
  </xsl:template>


  
  <xsl:template match="preparation">
    <ol><xsl:apply-templates select="step"/></ol>
  </xsl:template>

  <xsl:template match="step">
    <li><xsl:value-of select="node()"/></li>
  </xsl:template>

  <xsl:template match="comment">
    <ul>
      <li type="square"><xsl:value-of select="node()"/></li>
    </ul>
  </xsl:template>

  <xsl:template match="nutrition">
    <table border="2">
		  <tr>
        <th>Calories</th><th>Protein</th><th>Carbohydrates</th><th>Fat</th>
		   </tr>
		<tr>
        <td align="right"><xsl:value-of select="calories"/></td>
		    <td align="right"><xsl:value-of select="protein"/>
		          <xsl:value-of select="./amount"/>
		          <xsl:value-of select="./unit"/>
		    
		    </td>
		  <td align="right"><xsl:value-of select="carbohydrates"/>
		    <xsl:value-of select="./amount"/>
		    <xsl:value-of select="./unit"/>
		    
		  </td>
		  <td align="right"><xsl:value-of select="fat"/>
		    <xsl:value-of select="./amount"/>
		    <xsl:value-of select="./unit"/>
		    
		  </td>
        
		</tr> 
	</table>
		
  </xsl:template>



  
  <xsl:template match="preptime">
    <h4>Preparation time:<xsl:text> </xsl:text><xsl:value-of select="./time"/><xsl:text> </xsl:text><xsl:value-of select="./unit"/></h4>
  </xsl:template>
 
  <xsl:template match="cooktime">
    <h4>Cook time:<xsl:text> </xsl:text><xsl:value-of select="./time"/><xsl:text> </xsl:text><xsl:value-of select="./unit"/></h4>
  </xsl:template>
  
  <xsl:template match="totaltime">
    <h4>Total time:<xsl:text> </xsl:text><xsl:value-of select="./time"/><xsl:text> </xsl:text><xsl:value-of select="./unit"/></h4>
  </xsl:template>
  
 
</xsl:stylesheet>
