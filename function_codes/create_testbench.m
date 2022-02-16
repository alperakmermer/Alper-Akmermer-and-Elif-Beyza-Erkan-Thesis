function create_testbench(name,phase,quantizer) 
 
%%% Create File Name
s = num2str(phase);
fileName = name+"_tb";
s_end = "\n end" ;

functionName = "function "+fileName+"()" ;
initializeX = "q = quantizer('fixed','floor','saturate',["+num2str(quantizer)+"]);\n" ...
+ "Ts = 10e-6;\nfNy = 1 / Ts / 2; \nns = 1000;\nnf = 10; " ...
+ "\n\nfor i = 1:ns\nfreq(i) = (fNy/ns) * round(i/ns*nf)*ns/nf;\nend" ...
+ "\n\nfor i = 1:ns\nx(i) = cos(2*pi*freq(i)*Ts*i);\nend" ...
+ "\n\nx_in=num2hex(q,x);\nx_in=hex2num(q,x_in);\nlen=length(x_in);" ;

y_out = "y_out(ii) = zeros(1,len);" ;

forstart = "for ii=1:"+phase+":(len-("+phase+"-1))\n" ;

for i=1 : phase 
    y_outs(1,i) = "y_out(ii+"+(i-1)+")" ;
end   
for i=1 : phase 
    x_ins(1,i) = "x_in(ii+"+(i-1)+")" ;
end    
%%% Write to file
fileID = fopen(fileName+".m",'w');
fprintf(fileID,functionName+"\n\n");
fprintf(fileID,initializeX+"\n\n");

fprintf(fileID,forstart+"\n");
fprintf(fileID,"[");
for i=1:length(y_outs)
    if i<length(y_outs) 
        fprintf(fileID,y_outs(i)+",");
    else
        fprintf(fileID,y_outs(i)+"]");
    end
end
fprintf(fileID,"= "+name+"(");
for i=1:length(x_ins)
    if i<length(x_ins) 
        fprintf(fileID,x_ins(i)+",");
    else
        fprintf(fileID,x_ins(i)+");\n");
    end
end
fprintf(fileID,s_end) ; 

fprintf(fileID,"\n\n"+s_end) ; 
fclose(fileID);


end
