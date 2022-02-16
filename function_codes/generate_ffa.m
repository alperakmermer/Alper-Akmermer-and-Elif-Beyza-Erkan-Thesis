function generate_ffa(h,phase,type,quantizer) 

    name = ['filter_',num2str(phase),'_phase_',type,'_form'] ;
    mkdir(name);
    addpath(name);
    cd(name);
    ffa_gen(name,h,phase,type);
    create_testbench(name,phase,quantizer);
    create_generate_hdl(name);
    generate_hdl();
    create_table("Report "+name ,name)
    cd ..
%%
%     phase = 2*phase;
%     name = ['filter_',num2str(phase),'_phase_',type,'_form'] ;
%     mkdir(name);
%     addpath(name);
%     cd(name);
%     ffa_gen(name,h,phase,type);
%     create_testbench(name,phase,quantizer);
%     create_generate_hdl(name);
%     generate_hdl();
%     create_table("Report "+name ,name)
%     cd .. 
% %%
%     phase = phase * 1.5;
%     name = ['filter_',num2str(phase),'_phase_',type,'_form'] ;
%     mkdir(name);
%     addpath(name);
%     cd(name);
%     ffa_gen(name,h,phase,type);
%     create_testbench(name,phase,quantizer);
%     create_generate_hdl(name);
%     generate_hdl();
%     d=dir('*.m');
%     create_table("Report "+name ,name)
%     cd .. 
end



