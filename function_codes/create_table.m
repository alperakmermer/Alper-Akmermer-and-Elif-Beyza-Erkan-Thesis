function create_table(name,filter) 

filepath = "codegen\"+filter+"\hdlsrc\vivado_prj\timing_post_map.rpt" ;
str = extractFileText(filepath);

i = strfind(str,"Path Delay:        ");
ii = strfind(str,"ns  (");
start = i(1);
fin = ii(1);
delay_str = extractBetween(str,start+19,fin-1) ;
delay_int = str2num(delay_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% resource_report
%%%%% multiplier
filepath_html = "codegen\"+filter+"\hdlsrc\resource_report.html" ;
strhtml = extractFileText(filepath_html);

i = strfind(strhtml,"Multipliers");
ii = strfind(strhtml,"Adders/Subtractors");
start = i(1);
fin = ii(1);
multiplier_str = extractBetween(strhtml,start+13,fin-3) ;
multiplier_int = str2num(multiplier_str);
%%%%%% adder
i = strfind(strhtml,"Adders/Subtractors");
ii = strfind(strhtml,"Registers");
start = i(1);
fin = ii(1);
adder_str = extractBetween(strhtml,start+20,fin-3) ;
adder_int = str2num(adder_str);
%%%%%% register
i = strfind(strhtml,"Registers");
ii = strfind(strhtml,"Total 1 Bit Registers");
start = i(1);
fin = ii(1);
registers_str = extractBetween(strhtml,start+11,fin-3) ;
registers_int = str2num(registers_str);
%%%%%% Flip/Flop
i = strfind(strhtml,"Total 1 Bit Registers");
ii = strfind(strhtml,"RAMs");
start = i(1);
fin = ii(1);
flipflops_str = extractBetween(strhtml,start+23,fin-3) ;
flipflops_int = str2num(flipflops_str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filepath_util = "codegen\"+filter+"\hdlsrc\vivado_prj\"+filter+"_fixpt_vivado.runs\synth_1\"+filter+"_fixpt_utilization_synth.rpt" ;
strutil = extractFileText(filepath_util);


i = strfind(strutil,"| Slice LUTs*             |");
ii = strfind(strutil," |   ");
start = i(1);
fin = ii(1);
lut_str = extractBetween(strutil,start+27,fin-1) ;
lut_int = str2num(lut_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Table Gen

fig = uifigure('name',name);
uit = uitable(fig);
data = {delay_int,multiplier_int,adder_int,registers_int,flipflops_int,lut_int} ;
uit.ColumnName = {'Total Delay(ns)','Multipliers','Adders','Registers','Flip Flops','LUTS'};
uit.Data = data;
uit.ColumnWidth = 'auto' ;
uit.Position = [20 30 410 135];


%report = table(delay_str,multiplier_str,adder_str,registers_str,flipflops_str) ;

end
