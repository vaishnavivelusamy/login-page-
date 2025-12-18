{%- from "templates/print_formats/standard_macros.html" import 
add_header,
        render_field -%}
<html>   
<body> 
<br>


<table border= 1px width = "100%", bordercolor= black>   
    <tr>
        <td colspan=6>
            <center>
                <font size="1"><b> Supply Meant For Export Under LUT without Payment of IGST </b></font></td>
    </tr> 
   
    <tr>
<td colspan = 6><p style="font-size:15px; text-align:center; color: #022a46f3"> <b>PACKING LIST</b></p></td>
</tr>  
</table> 
<font face = "Trebuchet MS" ; font size="1">
<table border= 1px width = "100%", bordercolor= black>                   
    <tr>
            <td rowspan = 3; class="valign-top"> <strong> <p style="color: #ffffff; background-color: #030242">Exporters : </p></strong>
            {{doc.company_address}}<br> {{doc.company_address_display}}
            <!-- {{doc.company_gstin}}</b></td> -->
            <td class="valign-top"><strong> Packing list No. & Date: </strong><space><br> {{doc.rt_serial_code}}&nbsp; & &nbsp;{{doc.get_formatted("file_date")}} </br></td>
            <td class="valign-top"> <strong>Exporter's Ref : </strong><space><br> &nbsp;{{doc.exporters_ref or ''}}</br></td></tr>
        <tr>
            <td colspan = 2; class="valign-top"><strong>Buyer's Order No. & Date : </strong><space><br><b> ORDER NO.:{{doc.invoice_no}} &nbsp; & &nbsp;{{doc.get_formatted("po_date")}}</b></br> </td></tr>
        <tr>
            <td colspan = 2; class="valign-top"> <strong>Other Reference(s) : </strong><space> {{doc.other_reference}} <br>&nbsp; <b> DC# : {{doc.dc_no}}</b></br></td>
        </tr>
        <tr>
            <td rowspan = 4; class="valign-top"> <strong><p style="color: #ffffff; background-color: #030242">Consignee : </p></strong>
            {{doc.customer_address}}<br>
            {{doc.address_display}}</td>
        </tr> 
        <tr>    
            <td colspan = 3; class="valign-top"><strong>Buyer (if other then Consignee):</strong> <space> {{doc.buyer_cons or ''}}</td>
        </tr>
            <td class="valign-top"> <strong>Country of origin of goods : </strong><space><br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {{doc.country_of_origin}}</br> </td>  
            <td class="valign-top"><strong> Country of Final Destination : </strong> <space><br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  {{doc.country_of_final_destination}}</br></td>
            <tr>
            <td colspan = 2; class="valign-top"><strong> Terms of Delivery and Payment : </strong> &nbsp; <b>FOB&nbsp {{doc.get_formatted("fob")}} </b> </br></td>
        </tr> 
</table>
        
        
<table border= 1 width = "100%">  
                    
            <tr font face = "Trebuchet MS">
            <th><center>Pre-Carriage by</th>
            <th><center>Vessel / Flight No.</th>
            <th><center>Place of Receipt by Pre-carrier</th>
            <th><center>Port of Loading</th>
            <th><center>Port of Discharge</th>
            <th><center>Final Destination</th>
            </tr>
            <tr>
            <td><b><center>{{ doc.pre_carriage_by }}</b></td>
            <td><center>{{ doc.vessel_no or ''}}</td>
            <td><center>{{ doc.place_of_precarrier or ''}}</td>
            <td><b><center>{{ doc.port_of_loading }}</b></td>
            <td><b><center>{{ doc.port_of_discharge }}</b></td>
            <td><b><center>{{ doc.final_destination }}</b></td>
            </tr>
    </table> 

    <table border="1" width="100%" bordercolor="black" style="border-collapse: collapse;">
    <tr style="background-color: #f0f0f0;">
         <th>MARKS NO. CONTAINER NO.</th>
         <th>CTNS.NO</th>
         <th>CODE NUMBER</th>
         <th>ITEM CODE</th>
         <th>NO.OF.PCS/PER CTN</th>
         <th>QUANTITY</th> 
         <th>NO OF CTNS</th>
         <th>NET WT (IN KG)</th> 
         <th>GROSS WT</th>
    </tr>

    {% set ns = namespace(sum_ctns=0 , total_net=0, total_gross=0) %}
    
    {% for row in doc.items %}
        {% set ns.sum_ctns = ns.sum_ctns + row.no_of_crtns %}
        {% set ns.total_net = ns.total_net + (row.total_net_weight) %}
        {% set ns.total_gross = ns.total_gross + (row.total_gross_weight) %}
     {% endfor %}

    
    <tr>
        <td rowspan="1000" style="text-align:center; font-size:12px;">
            TOTAL CTNS : {{ ns.sum_ctns }} <br>{{ doc.marks_no }}
        </td>

        <td colspan="4" style="text-align:center;">
            <font size="1">
                COTTON POWERLOOM YARN DYED <br>
                MADEUPS OF INDIAN ORIGIN
            </font>
        </td>
        <td></td>
        <td  rowspan="1000"  style="text-align:center; font-size:12px;">{{ ns.sum_ctns }} </td> 
        <td  rowspan="1000"    style="text-align:center; font-size:12px;">{{ ns.total_net }}</td>
         <td  rowspan="1000"  style="text-align:center; font-size:12px;">{{ ns.total_gross }}</td>
        
    </tr>

    
    {% for group in doc.items | groupby('nest_code') %}
        {% set rows = group.list %}
      

        <tr>
            <td style="text-align:center; font-size:12px;">{{rows[0].from_ctn_nos}}</td>
            <td style="text-align:center; font-size:12px;">{{rows[0].buyer_code_number }}</td>
            <td style="text-align:center; font-size:12px;"><b>{{rows[0].composition }}</b><br>{{r.art_head }}</td>
            <td style="text-align:center; font-size:12px;">{{ rows[0].pcs_inner }}</td>
            <td style="text-align:center; font-size:12px;">{{ rows[0].qty }}</td>
        </tr>
    {% endfor %}

</table>
</body>
</html>