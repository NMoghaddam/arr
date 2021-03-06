<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:d="http://docbook.org/ns/docbook"
   xmlns:date="http://exslt.org/dates-and-times"
   xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions">
   <!-- This style sheet contains the common elements for ARR FO Processing -->

   <!-- Global Imports -->
   <!-- Import the normal FO stylesheet -->
   <!--  This path interacts with a catalog so may need to change -->
   <xsl:import href="../stylesheets-ns/fo/docbook.xsl" />

   <!-- Import the Custom Title Declarations -->
   <!--<xsl:import href="./arr_title_fo.xsl" /> -->

   <!-- Import the Common ARR Style Elements -->
   <xsl:import href="arr_style_common.xsl" />

   <!-- Import the local Set Cover Page Over Ride -->
   <xsl:import href="arr_style_fo_set_cover.xsl" />

   <!-- Define some parameters first -->
   <!-- Globally turn on FOP -->
   <xsl:param name="use.extensions">0</xsl:param>
   <xsl:param name="axf.extensions">1</xsl:param>
   <xsl:param name="fop.extensions">0</xsl:param>
   <xsl:param name="fop1.extensions">0</xsl:param>
   <xsl:param name="tablecolumns.extension">0</xsl:param>

   <!-- turn hyphenation on or off -->
   <xsl:param name="hyphenate">false</xsl:param>

   <!-- Page Details -->
   <!-- Define the we are using A4 -->
   <xsl:param name="paper.type" select="'A4'"/>

   <!-- Set Margins and Indents -->
   <!-- No paragraph indent: -->
   <xsl:param name="body.start.indent" select="'0pt'"/>


   <!-- Force No Page Numbers in XREFs -->
   <xsl:param name="insert.xref.page.number">no</xsl:param>
   <xsl:param name="insert.link.page.number">no</xsl:param>
   

   <!-- Font Details -->
   <!-- Force the base font to be 11pt Times -->
   <xsl:param name="body.font.master" select="11"/>
   <xsl:param name="body.font.family" select="'sans-serif'"/>
   <!-- Force the title font to be Times, with other customisations -->
   <!-- handled in the arr_title_fo.xml -->
   <xsl:param name="title.font.family" select="'sans-serif'"/>

   <!-- Section Fonts -->
   <!-- In the style guide this is level 2-->
   <xsl:attribute-set name="section.title.level1.properties">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- In the style guide this is level 3-->
   <xsl:attribute-set name="section.title.level2.properties">
      <xsl:attribute name="font-size">15pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- In the style guide this is level 4-->
   <xsl:attribute-set name="section.title.level3.properties">
      <xsl:attribute name="font-size">14pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- In the style guide this is level 5-->
   <xsl:attribute-set name="section.title.level4.properties">
      <xsl:attribute name="font-size">13pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- In the style guide this is level 6-->
   <xsl:attribute-set name="section.title.level5.properties">
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- In the style guide this is level 7-->
   <xsl:attribute-set name="section.title.level6.properties">
      <xsl:attribute name="font-size">11pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   
   <!-- XREF Font Properties -->
   <xsl:attribute-set name="xref.properties">
      <xsl:attribute name="text-decoration">underline</xsl:attribute>
   </xsl:attribute-set>



   <!-- Set Up the Chapter Titles -->
   <xsl:attribute-set name="component.title.properties">
      <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
      <xsl:attribute name="space-before.optimum"><xsl:value-of select="concat($body.font.master, 'pt')"></xsl:value-of></xsl:attribute>
      <xsl:attribute name="space-before.minimum"><xsl:value-of select="concat($body.font.master, 'pt * 0.8')"></xsl:value-of></xsl:attribute>
      <xsl:attribute name="space-before.maximum"><xsl:value-of select="concat($body.font.master, 'pt * 1.2')"></xsl:value-of></xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"></xsl:value-of></xsl:attribute>
   </xsl:attribute-set>
   <xsl:template name="arr.label.properties">
      <xsl:param name="node" select="."/>
      <fo:block xsl:use-attribute-sets="component.title.properties">
         <xsl:call-template name="gentext">
            <xsl:with-param name="key">chapter</xsl:with-param>
         </xsl:call-template>
         <xsl:text> </xsl:text>
         <xsl:apply-templates select="$node" mode="label.markup"/>
      </fo:block>
      <fo:block xsl:use-attribute-sets="component.title.properties">
         <xsl:apply-templates select="$node" mode="title.markup"/>
      </fo:block>
   </xsl:template>




   <!-- Section and Chapter numbering -->
   <xsl:param name="section.autolabel" select="1"/>
   <xsl:param name="section.label.includes.component.label" select="1"/>




   <!-- titles of figures and tables -->
   <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
      <xsl:attribute name="font-weight">normal</xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="font-size">11pt</xsl:attribute>
      <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
      <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>

   <!-- Table of Contents Formatting -->
   <!-- Set which elements get TOCs etc -->
   <xsl:param name="generate.toc">
      /appendix toc,title
      article/appendix  nop
      /article  toc,title
      book      toc,title,figure,table,example,equation
      /chapter  toc,title
      part      toc,title
      /preface  toc,title
      reference toc,title
      /sect1    toc
      /sect2    toc
      /sect3    toc
      /sect4    toc
      /sect5    toc
      /section  toc
      set       toc
   </xsl:param>
   <!-- Only Display Books at the Set Level TOC -->
   <xsl:template match="d:book|d:setindex" mode="toc">
      <xsl:param name="toc-context" select="."/>
      <xsl:call-template name="toc.line.arr"/>
   </xsl:template>
   <!-- And then override so that we just have the book title
        centred on the page -->
   <xsl:template name="toc.line.arr">
      <xsl:param name="toc-context" select="NOTANODE"/>  
      <xsl:variable name="id">  
         <xsl:call-template name="object.id"/>
      </xsl:variable>

      <xsl:variable name="label">  
         <xsl:apply-templates select="." mode="label.markup"/>  
      </xsl:variable>

      <fo:block text-align="center">  
         <fo:inline keep-with-next.within-line="always">
            <fo:basic-link internal-destination="{$id}">  
               <xsl:if test="$label != ''">
                  <xsl:copy-of select="$label"/>
                  <xsl:value-of select="$autotoc.label.separator"/>
               </xsl:if>
               <xsl:apply-templates select="." mode="title.markup"/>  
            </fo:basic-link>
         </fo:inline>
      </fo:block>
   </xsl:template>

   <!-- Overwrite List of Tables/Figures to add a line space -->
   <xsl:template match="d:figure|d:table|d:example|d:equation|d:procedure" mode="toc">
      <xsl:param name="toc-context" select="."/>
      <xsl:call-template name="toc.line2">
         <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
      <fo:block font-size="4pt"><xsl:text>&#xA0;</xsl:text></fo:block>
   </xsl:template>

   <xsl:template name="toc.line2">
      <xsl:param name="toc-context" select="NOTANODE"/>

      <xsl:variable name="id">
         <xsl:call-template name="object.id"/>
      </xsl:variable>

      <xsl:variable name="label">
         <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>

      <fo:block xsl:use-attribute-sets="toc.line.properties" white-space="pre">
         <fo:inline keep-with-next.within-line="always">
            <fo:basic-link internal-destination="{$id}">
               <xsl:if test="$label != ''">
                  <xsl:copy-of select="$label"/>
                  <!-- <xsl:text>   </xsl:text> -->
                  <xsl:value-of select="$autotoc.label.separator"/>
               </xsl:if>
               <xsl:apply-templates select="." mode="titleabbrev.markup"/>
            </fo:basic-link>
         </fo:inline>
         <fo:inline keep-together.within-line="always">
            <xsl:text> </xsl:text>
               <fo:leader leader-pattern="dots"
                           leader-pattern-width="3pt"
                           leader-alignment="reference-area"
                           keep-with-next.within-line="always"/>
               <xsl:text> </xsl:text> 
               <fo:basic-link internal-destination="{$id}">
                  <fo:page-number-citation ref-id="{$id}"/>
               </fo:basic-link>
            </fo:inline>
         </fo:block>
      </xsl:template>


   <!-- Equations centred with number on the right
      See also below in the XREF numbering section for how the XREF
      gentext is handled -->
   <xsl:template name="equation.without.title">
      <!-- Lay out equation and number next to equation using a table -->
      <fo:table table-layout="fixed" width="100%">
         <fo:table-column column-width="proportional-column-width(15)"/>
         <fo:table-column column-width="proportional-column-width(2)"/>
         <fo:table-body start-indent="0pt" end-indent="0pt">
            <fo:table-row>
               <fo:table-cell padding-end="6pt" text-align="center">
                  <fo:block>
                     <xsl:apply-templates/>
                  </fo:block>
               </fo:table-cell>
               <fo:table-cell xsl:use-attribute-sets="equation.number.properties">
                  <fo:block>
                     <xsl:text>(</xsl:text>
                     <xsl:apply-templates select="." mode="label.markup"/>
                     <xsl:text>)</xsl:text>
                  </fo:block>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>
   
   <!-- Gentex overrides
      Start simple and amend the gentext blocks as that is simplest but then
      if we get hardcore then directly amend the underlying templates -->
   <xsl:param name="local.l10n.xml" select="document('')"/>
   <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
      <l:l10n language="en">
         <l:context name="title">
            <l:template name="equation" text="Equation &#40;%n&#41;"/>
         </l:context>
         <l:context name="xref">
            <l:template name="equation" text="Equation &#40;%n&#41;"/>
         </l:context>
         <l:context name="xref-number">
            <l:template name="equation" text="Equation &#40;%n&#41;"/>
            <l:template name="sect1" text="&#167;%n"/>
            <l:template name="sect2" text="&#167;%n"/>
            <l:template name="sect3" text="&#167;%n"/>
            <l:template name="sect4" text="&#167;%n"/>
            <l:template name="sect5" text="&#167;%n"/>
            <l:template name="section" text="&#167;%n"/>
         </l:context>
      </l:l10n>
   </l:i18n>
   <!-- Get the book number and override the default xref template for book
      xrefs from "title" to: Book n -->
   <xsl:template match="d:book" mode="xref-to">
      <xsl:param name="referrer"/>
      <xsl:param name="xrefstyle"/>
      <xsl:param name="verbose" select="1"/>
      
      <xsl:text>Book </xsl:text>
      <xsl:value-of select="count(preceding-sibling::d:book)+1"/>
   </xsl:template>
   <!-- Override the chapter template to be of the form Book N, Chapter M
      instead of "Chapter M" -->
   <xsl:template match="d:chapter" mode="xref-to">
      <xsl:param name="referrer"/>
      <xsl:param name="xrefstyle"/>
      <xsl:param name="verbose" select="1"/>
      
      <xsl:text>Book </xsl:text>
      <xsl:value-of select="count(ancestor::d:book/preceding-sibling::d:book)+1"/>
      <xsl:text>, Chapter </xsl:text>
      <xsl:value-of select="count(preceding-sibling::d:chapter)+1"/>
   </xsl:template>
   <!-- Override the section template to be of the form Book N, Chapter M, Section L
      instead of "Chapter M" But only down to the first section level -->
   <xsl:template match="d:section" mode="xref-to">
      <xsl:param name="referrer"/>
      <xsl:param name="xrefstyle"/>
      <xsl:param name="verbose" select="1"/>
      
      <xsl:text>Book </xsl:text>
      <xsl:value-of select="count(ancestor::d:book/preceding-sibling::d:book)+1"/>
      <xsl:text>, Chapter </xsl:text>
      <xsl:value-of select="count(ancestor::d:chapter/preceding-sibling::d:chapter)+1"/>
      <xsl:text>, Section </xsl:text>
      <xsl:value-of select="count((ancestor-or-self::d:section)[1]/preceding-sibling::d:section)+1"/>
   </xsl:template>


   <!-- Default Table Formatting -->
   <!-- Set the global parameters that controil tables -->
   <xsl:param name="table.cell.border.thickness">.5mm</xsl:param>
   <xsl:param name="table.cell.border.style">solid</xsl:param>
   <xsl:param name="table.cell.border.color">#005092</xsl:param>
   <!-- Add some row colouring 
        This is based on table.row.properties template that is contained in
        fo/table.xsl.  With additions -->
   <xsl:template name="table.row.properties">
      <!-- This is the original content: -->
      <xsl:variable name="row-height">
         <xsl:if test="processing-instruction('dbfo')">
            <xsl:call-template name="pi.dbfo_row-height"/>
         </xsl:if>
      </xsl:variable>

      <xsl:if test="$row-height != ''">
         <xsl:attribute name="block-progression-dimension">
            <xsl:value-of select="$row-height"/>
         </xsl:attribute>
      </xsl:if>

      <xsl:variable name="bgcolor">
         <xsl:call-template name="pi.dbfo_bgcolor"/>
      </xsl:variable>

      <xsl:if test="$bgcolor != ''">
         <xsl:attribute name="background-color">
            <xsl:value-of select="$bgcolor"/>
         </xsl:attribute>
      </xsl:if>

      <!-- Keep header row with next row -->
      <xsl:if test="ancestor::d:thead">
         <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
      </xsl:if>
      <xsl:variable name="rownum">
         <xsl:number from="d:tbody" count="d:tr"/>
      </xsl:variable>


      <!-- Now the specific overrides: add alternate colors to the rows of the
           body of the table -->
      <xsl:choose>
         <xsl:when test="name(..) = 'tbody'">
            <xsl:choose>
               <xsl:when test="$rownum mod 2">
                  <xsl:attribute name="background-color">#b9daf3</xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="background-color">#FFFFFF</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <!-- I'm amending the table.cell.properies template to provide the specific
        colour and alignment formatting for tables.  This is done in two steps:
        1) copy in the original template from fo/table.xsl
        2) add/edit as desired. -->
   <xsl:template name="table.cell.properties">
      <xsl:param name="bgcolor.pi" select="''"/>
      <xsl:param name="rowsep.inherit" select="1"/>
      <xsl:param name="colsep.inherit" select="1"/>
      <xsl:param name="col" select="1"/>
      <xsl:param name="valign.inherit" select="''"/>
      <xsl:param name="align.inherit" select="''"/>
      <xsl:param name="char.inherit" select="''"/>

      <xsl:choose>
         <xsl:when test="ancestor::d:tgroup">
            <xsl:if test="$bgcolor.pi != ''">
               <xsl:attribute name="background-color">
                  <xsl:value-of select="$bgcolor.pi"/>
               </xsl:attribute>
            </xsl:if>

            <xsl:if test="$rowsep.inherit &gt; 0">
               <xsl:call-template name="border">
                  <xsl:with-param name="side" select="'bottom'"/>
               </xsl:call-template>
            </xsl:if>

            <xsl:if test="$colsep.inherit &gt; 0 and 
               $col &lt; (ancestor::d:tgroup/@cols|ancestor::d:entrytbl/@cols)[last()]">
               <xsl:call-template name="border">
                  <xsl:with-param name="side" select="'end'"/>
               </xsl:call-template>
            </xsl:if>

            <xsl:if test="$valign.inherit != ''">
               <xsl:attribute name="display-align">
                  <xsl:choose>
                     <xsl:when test="$valign.inherit='top'">before</xsl:when>
                     <xsl:when test="$valign.inherit='middle'">center</xsl:when>
                     <xsl:when test="$valign.inherit='bottom'">after</xsl:when>
                     <xsl:otherwise>
                        <xsl:message>
                           <xsl:text>Unexpected valign value: </xsl:text>
                           <xsl:value-of select="$valign.inherit"/>
                           <xsl:text>, center used.</xsl:text>
                        </xsl:message>
                        <xsl:text>center</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:attribute>
            </xsl:if>

            <xsl:choose>
               <xsl:when test="$align.inherit = 'char' and $char.inherit != ''">
                  <xsl:attribute name="text-align">
                     <xsl:value-of select="$char.inherit"/>
                  </xsl:attribute>
               </xsl:when>
               <xsl:when test="$align.inherit != ''">
                  <xsl:attribute name="text-align">
                     <xsl:value-of select="$align.inherit"/>
                  </xsl:attribute>
               </xsl:when>
            </xsl:choose>

         </xsl:when>
         <xsl:otherwise>
            <!-- HTML table -->
            <xsl:if test="$bgcolor.pi != ''">
               <xsl:attribute name="background-color">
                  <xsl:value-of select="$bgcolor.pi"/>
               </xsl:attribute>
            </xsl:if>

            <xsl:if test="$align.inherit != ''">
               <xsl:attribute name="text-align">
                  <xsl:value-of select="$align.inherit"/>
               </xsl:attribute>
            </xsl:if>

            <xsl:if test="$valign.inherit != ''">
               <xsl:attribute name="display-align">
                  <xsl:choose>
                     <xsl:when test="$valign.inherit='top'">before</xsl:when>
                     <xsl:when test="$valign.inherit='middle'">center</xsl:when>
                     <xsl:when test="$valign.inherit='bottom'">after</xsl:when>
                     <xsl:otherwise>
                        <xsl:message>
                           <xsl:text>Unexpected valign value: </xsl:text>
                           <xsl:value-of select="$valign.inherit"/>
                           <xsl:text>, center used.</xsl:text>
                        </xsl:message>
                        <xsl:text>center</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:attribute>
            </xsl:if>

            <xsl:call-template name="html.table.cell.rules"/>

            <!-- The following add specific processor instructions to format
                 the table headers but only if we are inside a HTML table-->
            <xsl:choose>
               <xsl:when test="ancestor::d:thead">
                  <xsl:attribute name="background-color">#0074b4</xsl:attribute>
                  <xsl:attribute name="color">#FFFFFF</xsl:attribute>
                  <xsl:attribute name="text-align">center</xsl:attribute>
                  <xsl:attribute name="border-color">#b9daf3</xsl:attribute>
               </xsl:when>
            </xsl:choose>
            <xsl:choose>
               <xsl:when test="ancestor::d:tbody">
                  <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
                  <xsl:attribute name="border-width">0.2mm</xsl:attribute>
                  <xsl:attribute name="border-color">#005092</xsl:attribute>
                  <xsl:attribute name="border-start-style">solid</xsl:attribute>
                  <xsl:attribute name="border-end-style">solid</xsl:attribute>
               </xsl:when>
            </xsl:choose>


         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- This is amending the d:table|d:informal table from htmltbl.xsl
        to horizontally centre the table -->
   <xsl:template match="d:table|d:informaltable" mode="htmlTable">

      <xsl:variable name="numcols">
         <xsl:call-template name="widest-html-row">
            <xsl:with-param name="rows" select=".//d:tr"/>
         </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="prop-columns"
         select=".//d:col[contains(@width, '%')] |
         .//d:colgroup[contains(@width, '%')]"/>

      <xsl:variable name="table.width">
         <xsl:call-template name="table.width"/>
      </xsl:variable>

      <fo:table-and-caption text-align="center">
         <fo:table xsl:use-attribute-sets="table.table.properties">
            <xsl:choose>
               <xsl:when test="$fop.extensions != 0 or
                  $fop1.extensions != 0">
                  <xsl:attribute name="table-layout">fixed</xsl:attribute>
               </xsl:when>
            </xsl:choose>

            <xsl:attribute name="width">
               <xsl:choose>
                  <xsl:when test="@width">
                     <xsl:value-of select="@width"/>
                  </xsl:when>
                  <xsl:when test="$table.width">
                     <xsl:value-of select="$table.width"/>
                  </xsl:when>
                  <xsl:otherwise>100%</xsl:otherwise>
               </xsl:choose>
            </xsl:attribute>

            <xsl:call-template name="table.frame">
               <xsl:with-param name="frame">
                  <xsl:choose>
                     <xsl:when test="@frame = 'box'">all</xsl:when>
                     <xsl:when test="@frame = 'border'">all</xsl:when>
                     <xsl:when test="@frame = 'below'">bottom</xsl:when>
                     <xsl:when test="@frame = 'above'">top</xsl:when>
                     <xsl:when test="@frame = 'hsides'">topbot</xsl:when>
                     <xsl:when test="@frame = 'vsides'">sides</xsl:when>
                     <xsl:when test="@frame = 'lhs'">lhs</xsl:when>
                     <xsl:when test="@frame = 'rhs'">rhs</xsl:when>
                     <xsl:when test="@frame = 'void'">none</xsl:when>
                     <xsl:when test="@border != '' and @border != 0">all</xsl:when>
                     <xsl:when test="@border != '' and @border = 0">none</xsl:when>
                     <xsl:when test="@frame != ''">
                        <xsl:value-of select="@frame"/>
                     </xsl:when>
                     <xsl:when test="$default.table.frame != ''">
                        <xsl:value-of select="$default.table.frame"/>
                     </xsl:when>
                     <xsl:otherwise>all</xsl:otherwise>
                  </xsl:choose>
               </xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="make-html-table-columns">
               <xsl:with-param name="count" select="$numcols"/>
            </xsl:call-template>

            <xsl:apply-templates select="d:thead" mode="htmlTable"/>
            <xsl:apply-templates select="d:tfoot" mode="htmlTable"/>
            <xsl:choose>
               <xsl:when test="d:tbody">
                  <xsl:apply-templates select="d:tbody" mode="htmlTable"/>
               </xsl:when>
               <xsl:otherwise>
                  <fo:table-body start-indent="0pt" end-indent="0pt">
                     <xsl:apply-templates select="d:tr" mode="htmlTable"/>
                  </fo:table-body>
               </xsl:otherwise>
            </xsl:choose>
         </fo:table>
      </fo:table-and-caption>
   </xsl:template>



   <!-- Header and Footer Changes: -->
   <!--   - Move the "Draft" marks to the footer" -->
   <xsl:template name="header.content">
      <xsl:param name="pageclass" select="''"/>
      <xsl:param name="sequence" select="''"/>
      <xsl:param name="position" select="''"/>
      <xsl:param name="gentext-key" select="''"/>

      <!-- <fo:block> -->
         <!-- <xsl:value-of select="$pageclass"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$sequence"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$position"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$gentext-key"/> -->
         <!-- </fo:block> -->
      <xsl:choose>
         <xsl:when test="$gentext-key='set'">
            <!-- insert nothing for the set -->
         </xsl:when>
         <xsl:otherwise>
            <!-- elswhere insert headers: -->
            
      
      <fo:block>

         <!-- sequence can be odd, even, first, blank -->
         <!-- position can be left, center, right -->
         <xsl:choose>
            <xsl:when test="$sequence = 'blank'">
               <!-- nothing -->
            </xsl:when>

            <xsl:when test="$position='left'">
               <!-- Same for odd, even, empty, and blank sequences -->
               <!--<xsl:call-template name="draft.text"/>-->

               <xsl:call-template name="arr.draft.status">
                  <xsl:with-param name="position" select="$position"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
               <xsl:if test="$pageclass != 'titlepage'">
                  <xsl:choose>
                     <xsl:when test="ancestor::d:book and ($double.sided != 0)">
                        <fo:retrieve-marker retrieve-class-name="section.head.marker"
                           retrieve-position="first-including-carryover"
                           retrieve-boundary="page-sequence"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:if>
            </xsl:when>

            <xsl:when test="$position='center'">
               <!-- nothing for empty and blank sequences -->
            </xsl:when>

            <xsl:when test="$position='right'">
               <!-- Same for odd, even, empty, and blank sequences -->
               <!--<xsl:call-template name="draft.text"/>-->
               <xsl:call-template name="arr.draft.status">
                  <xsl:with-param name="position" select="$position"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="$sequence = 'first'">
               <!-- nothing for first pages -->
            </xsl:when>

            <xsl:when test="$sequence = 'blank'">
               <!-- nothing for blank pages -->
            </xsl:when>
         </xsl:choose>
      </fo:block>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="footer.content">
      <xsl:param name="pageclass" select="''"/>
      <xsl:param name="sequence" select="''"/>
      <xsl:param name="position" select="''"/>
      <xsl:param name="gentext-key" select="''"/>

      <!-- <fo:block> -->
         <!-- <xsl:value-of select="$pageclass"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$sequence"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$position"/> -->
         <!-- <xsl:text>, </xsl:text> -->
         <!-- <xsl:value-of select="$gentext-key"/> -->
         <!-- </fo:block> -->

      <xsl:choose>
         <xsl:when test="$gentext-key='set'">
            <!-- insert nothing for the set -->
         </xsl:when>
         <xsl:otherwise>
            <!-- elswhere insert headers: -->
      <fo:block>
         <!-- pageclass can be front, body, back -->
         <!-- sequence can be odd, even, first, blank -->
         <!-- position can be left, center, right -->
         <xsl:choose>
            <xsl:when test="$pageclass = 'titlepage'">
               <!-- nop; no footer on title pages -->
            </xsl:when>

            <xsl:when test="$double.sided != 0 and $sequence = 'even'
               and $position='left'">
               <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
               and $position='right'">
               <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided = 0 and $position='center'">
               <fo:page-number/>
            </xsl:when>

            <xsl:when test="$double.sided = 0 and $position='left'">
               <!-- Same for odd, even, empty, and blank sequences -->
               <xsl:call-template name="draft.text"/>
               <xsl:choose>
                  <xsl:when test="$draft.mode = 'yes'">
                     <xsl:text> Printed: </xsl:text>
                     <xsl:call-template name="datetime.format">
                        <xsl:with-param name="date" select="date:date-time()"/>
                        <xsl:with-param name="format" select="'Y-m-d'"/>
                     </xsl:call-template>
                  </xsl:when>
               </xsl:choose>
            </xsl:when>

            <xsl:when test="$sequence='blank'">
               <xsl:choose>
                  <xsl:when test="$double.sided != 0 and $position = 'left'">
                     <fo:page-number/>
                  </xsl:when>
                  <xsl:when test="$double.sided = 0 and $position = 'center'">
                     <fo:page-number/>
                  </xsl:when>
                  <xsl:otherwise>
                     <!-- nop -->
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>

            <xsl:when test="$double.sided = 0 and $position='right'">
               <!-- Same for odd, even, empty, and blank sequences -->
               <xsl:call-template name="draft.text"/>
            </xsl:when>

            <xsl:otherwise>
               <!-- nop -->
            </xsl:otherwise>
         </xsl:choose>
      </fo:block>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <!-- Book Title Page -->
   <xsl:template name="book.titlepage.recto">
      <fo:block>
         <fo:table inline-progression-dimension="100%" table-layout="fixed">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
               <fo:table-row height="20cm">
                  <fo:table-cell display-align="center">
                     <fo:block text-align="center">
                        <xsl:text>BOOK </xsl:text><xsl:number format="1" count="d:book" from="d:set" level="any"/>
                     </fo:block>
                     <fo:block text-align="center">
                        <xsl:choose>
                           <xsl:when test="d:bookinfo/d:title">
                              <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:setinfo/d:title"/>
                           </xsl:when>
                           <xsl:when test="d:info/d:title">
                              <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:title"/>
                           </xsl:when>
                           <xsl:when test="d:title">
                              <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:title"/>
                           </xsl:when>
                        </xsl:choose>
                     </fo:block>
                  </fo:table-cell>
               </fo:table-row>
            </fo:table-body>
         </fo:table>
      </fo:block>
   </xsl:template>

   <!-- Author Template -->
   <xsl:template match="d:author" mode="titlepage.mode">
      <fo:block text-align="center">
         <xsl:call-template name="anchor"/>
         <xsl:choose>
            <xsl:when test="d:orgname">
               <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="person.name"/>
               <xsl:if test="d:affiliation/d:orgname">
                  <fo:block font-size="12pt" font-weight="normal">
                     <xsl:apply-templates select="d:affiliation/d:orgname" mode="titlepage.mode"/>
                  </fo:block>
               </xsl:if>
               <xsl:if test="d:email|d:affiliation/d:address/d:email">
                  <xsl:text> </xsl:text>
                  <xsl:apply-templates select="(d:email|d:affiliation/d:address/d:email)[1]"/>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </fo:block>
   </xsl:template>


   <!-- Template to insert the status of the document -->
   <xsl:template name="arr.draft.status">
      <xsl:param name="position" select="''"/>
      <xsl:choose>
         <xsl:when test="$draft.mode = 'yes'">
            <xsl:choose>
               <xsl:when test="$position='left'">
                  <xsl:text>Book </xsl:text><xsl:number format="1" count="d:book" from="d:set" level="any"/>
               </xsl:when>

               <xsl:when test="$position='right' and ancestor-or-self::d:chapter/@status">
                  <xsl:text>Chapter Status: </xsl:text><xsl:value-of select="ancestor-or-self::d:chapter/@status"/>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
      </xsl:choose>
   </xsl:template>


   <!-- Landscape Figures
      This is designed to:
      -) rotate a large figure and its associated caption by 90 degrees
      -) force a page break to dump the figure onto a new page
      -) scale the figure to fit the full page
      -->
   <xsl:template match="d:figure[processing-instruction('landscapeFigure')]">
      <fo:block break-after='page'/>
      <fo:block-container reference-orientation="90"
         absolute-position="absolute"
         top="0mm"
         left="0mm"
         width="250mm"
         height="200mm">
         <xsl:apply-imports/>
      </fo:block-container>
      <fo:block break-after='page'/>
   </xsl:template>

   <!-- Redefine the following template to center all images -->
   <xsl:template match="d:mediaobject|d:mediaobjectco">
      <xsl:variable name="olist" select="d:imageobject|d:imageobjectco
         |d:videoobject|d:audioobject
         |d:textobject"/>

      <xsl:variable name="object.index">
         <xsl:call-template name="select.mediaobject.index">
            <xsl:with-param name="olist" select="$olist"/>
            <xsl:with-param name="count" select="1"/>
         </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="object" select="$olist[position() = $object.index]"/>

      <xsl:variable name="align">
         <xsl:value-of select="$object/descendant::d:imagedata[@align][1]/@align"/>
      </xsl:variable>

      <xsl:variable name="id">
         <xsl:call-template name="object.id"/>
      </xsl:variable>

      <fo:block id="{$id}">
         <xsl:attribute name="text-align">
            center
         </xsl:attribute>

         <xsl:apply-templates select="$object"/>
         <xsl:apply-templates select="d:caption"/>
      </fo:block>
   </xsl:template>


   <!-- Glossary formatting-->

   <!-- Change the xref style: -->
   <!-- In this I've replaced the d:glossterm template to force a link then-->
   <!-- to a custom template that underlines the glossdiv xref -->
   <xsl:template match="d:glossterm" name="glossterm">
      <xsl:param name="firstterm" select="0"/>

      <xsl:choose>
         <xsl:when test="($firstterm.only.link = 0 or $firstterm = 1) and @linkend">
            <xsl:variable name="targets" select="key('id',@linkend)"/>
            <xsl:variable name="target" select="$targets[1]"/>

            <xsl:choose>
               <xsl:when test="$target">
                  <fo:basic-link internal-destination="{@linkend}" 
                     xsl:use-attribute-sets="xref.properties">
                     <xsl:call-template name="inline.arrglossdiv"/>
                  </fo:basic-link>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="inline.arrglossdiv"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="not(@linkend)
            and ($firstterm.only.link = 0 or $firstterm = 1)
            and ($glossterm.auto.link != 0)
            and $glossary.collection != ''">
            <xsl:variable name="term">
               <xsl:choose>
                  <xsl:when test="@baseform"><xsl:value-of select="@baseform"/></xsl:when>
                  <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
               </xsl:choose>
            </xsl:variable>
            <xsl:variable name="cterm"
               select="(document($glossary.collection,.)//d:glossentry[d:glossterm=$term])[1]"/>

            <xsl:choose>
               <xsl:when test="not($cterm)">
                  <xsl:message>
                     <xsl:text>There's no entry for </xsl:text>
                     <xsl:value-of select="$term"/>
                     <xsl:text> in </xsl:text>
                     <xsl:value-of select="$glossary.collection"/>
                  </xsl:message>
                  <xsl:call-template name="inline.arrglossdiv"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:variable name="id">
                     <xsl:call-template name="object.id">
                        <xsl:with-param name="object" select="$cterm"/>
                     </xsl:call-template>
                  </xsl:variable>
                  <fo:basic-link internal-destination="{$id}"
                     xsl:use-attribute-sets="xref.properties">
                     <xsl:call-template name="inline.arrglossdiv"/>
                  </fo:basic-link>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="not(@linkend)
            and ($firstterm.only.link = 0 or $firstterm = 1)
            and $glossterm.auto.link != 0">
            <xsl:variable name="term">
               <xsl:choose>
                  <xsl:when test="@baseform">
                     <xsl:value-of select="normalize-space(@baseform)"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="normalize-space(.)"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable>

            <xsl:variable name="targets"
               select="key('glossentries', $term)"/>
            <xsl:variable name="target" select="$targets[1]"/>

            <xsl:choose>
               <xsl:when test="count($targets)=0">
                  <xsl:message>
                     <xsl:text>Error: no glossentry for glossterm: </xsl:text>
                     <xsl:value-of select="."/>
                     <xsl:text>.</xsl:text>
                  </xsl:message>
                  <xsl:call-template name="inline.arrglossdiv"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:variable name="termid">
                     <xsl:call-template name="object.id">
                        <xsl:with-param name="object" select="$target"/>
                     </xsl:call-template>
                  </xsl:variable>

                  <fo:basic-link internal-destination="{$termid}"
                     xsl:use-attribute-sets="xref.properties">
                     <xsl:call-template name="inline.arrglossdiv"/>
                  </fo:basic-link>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="inline.arrglossdiv"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="inline.arrglossdiv">
      <xsl:param name="content">
         <xsl:call-template name="simple.xlink">
            <xsl:with-param name="content">
               <xsl:apply-templates/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:param>

      <fo:inline text-decoration="underline" axf:text-line-style="dashed">
         <xsl:call-template name="anchor"/>
         <xsl:if test="@dir">
            <xsl:attribute name="direction">
               <xsl:choose>
                  <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
                  <xsl:otherwise>rtl</xsl:otherwise>
               </xsl:choose>
            </xsl:attribute>
         </xsl:if>
         <xsl:copy-of select="$content"/>
      </fo:inline>
   </xsl:template>
   
   
   <!-- Variable List Formatting -->
   <!-- We want to format these as a block with the term on top
      followed by a new paragraph slightly indented with the
      definition -->
   <xsl:param name="variablelist.as.blocks" select="1"/>
   <xsl:attribute-set name="variablelist.term.properties">
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>
   
   <!-- Author Arrangements
      Specifically:
      -) drop affiliations
      -) horizontal list
   -->
   <xsl:template name="chapter.titlepage.recto">
      <xsl:choose>
         <xsl:when test="d:chapterinfo/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:chapterinfo/d:title"/>
         </xsl:when>
         <xsl:when test="d:docinfo/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:docinfo/d:title"/>
         </xsl:when>
         <xsl:when test="d:info/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:info/d:title"/>
         </xsl:when>
         <xsl:when test="d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:title"/>
         </xsl:when>
      </xsl:choose>
      
      <xsl:choose>
         <xsl:when test="d:chapterinfo/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:chapterinfo/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:docinfo/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:docinfo/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:info/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:subtitle"/>
         </xsl:when>
      </xsl:choose>
      
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" text-align="center" space-before="0.5em" space-after="0.5em" font-size="14pt">
         <xsl:for-each select=".//d:author">
            <xsl:call-template name="person.name"/>
            <xsl:if test="position() != last()">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:for-each>
      </fo:block>
   </xsl:template>
   
   
   <!-- Override the d:link template to drop page numbers
      on targets to para objects as we are using these
      for reference links.
      -->
   <xsl:template match="d:link" name="link">
      <xsl:param name="linkend" select="@linkend"/>
      <xsl:param name="targets" select="key('id',$linkend)"/>
      <xsl:param name="target" select="$targets[1]"/>
      
      <xsl:variable name="xrefstyle">
         <xsl:choose>
            <xsl:when test="@role and not(@xrefstyle) 
               and $use.role.as.xrefstyle != 0">
               <xsl:value-of select="@role"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="@xrefstyle"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="content">
         <fo:inline xsl:use-attribute-sets="xref.properties">
            <xsl:choose>
               <xsl:when test="count(child::node()) &gt; 0">
                  <!-- If it has content, use it -->
                  <xsl:apply-templates/>
               </xsl:when>
               <!-- look for an endterm -->
               <xsl:when test="@endterm">
                  <xsl:variable name="etargets" select="key('id',@endterm)"/>
                  <xsl:variable name="etarget" select="$etargets[1]"/>
                  <xsl:choose>
                     <xsl:when test="count($etarget) = 0">
                        <xsl:message>
                           <xsl:value-of select="count($etargets)"/>
                           <xsl:text>Endterm points to nonexistent ID: </xsl:text>
                           <xsl:value-of select="@endterm"/>
                        </xsl:message>
                        <xsl:text>???</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates select="$etarget" mode="endterm"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <!-- Use the xlink:href if no other text -->
               <xsl:when test="@xlink:href">
                  <fo:inline hyphenate="false">
                     <xsl:call-template name="hyphenate-url">
                        <xsl:with-param name="url" select="@xlink:href"/>
                     </xsl:call-template>
                  </fo:inline>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message>
                     <xsl:text>Link element has no content and no Endterm. </xsl:text>
                     <xsl:text>Nothing to show in the link to </xsl:text>
                     <xsl:value-of select="$target"/>
                  </xsl:message>
                  <xsl:text>???</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </fo:inline>
      </xsl:variable>
      
      <xsl:call-template name="simple.xlink">
         <xsl:with-param name="node" select="."/>
         <xsl:with-param name="linkend" select="$linkend"/>
         <xsl:with-param name="content" select="$content"/>
      </xsl:call-template>
      
      <!-- Add standard page reference? -->
      <xsl:choose>
         <!-- page numbering on link only enabled for @linkend -->
         <!-- There is no link element in DB5 with xlink:href -->
         <xsl:when test="not($linkend)">
         </xsl:when>
         <!-- negative xrefstyle in instance turns it off -->
         <xsl:when test="starts-with(normalize-space($xrefstyle), 'select:') 
            and contains($xrefstyle, 'nopage')">
         </xsl:when>
         <xsl:when test="(starts-with(normalize-space($xrefstyle), 'select:') 
            and $insert.link.page.number = 'maybe'  
            and (contains($xrefstyle, 'page')
            or contains($xrefstyle, 'Page')))
            or ( $insert.link.page.number = 'yes' 
            or $insert.link.page.number = '1')">
            <xsl:apply-templates select="$target" mode="page.citation">
               <xsl:with-param name="id" select="$linkend"/>
            </xsl:apply-templates>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   
   
</xsl:stylesheet>
