set_property PACKAGE_PIN W7 [get_ports {cathodes[7]}]
set_property PACKAGE_PIN W6 [get_ports {cathodes[6]}]
set_property PACKAGE_PIN U8 [get_ports {cathodes[5]}]
set_property PACKAGE_PIN V8 [get_ports {cathodes[4]}]
set_property PACKAGE_PIN U5 [get_ports {cathodes[3]}]
set_property PACKAGE_PIN V5 [get_ports {cathodes[2]}]
set_property PACKAGE_PIN U7 [get_ports {cathodes[1]}]
set_property PACKAGE_PIN W4 [get_ports {AN[3]}]
set_property PACKAGE_PIN V4 [get_ports {AN[2]}]
set_property PACKAGE_PIN U4 [get_ports {AN[1]}]
set_property PACKAGE_PIN U2 [get_ports {AN[0]}]
set_property PACKAGE_PIN W5 [get_ports clk]
set_property PACKAGE_PIN T18 [get_ports reset]

set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cathodes[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# #S0
# set_property PACKAGE_PIN V17 [get_ports mem2uart]
# set_property IOSTANDARD LVCMOS33 [get_ports mem2uart]

# #reverse
# set_property PACKAGE_PIN V16 [get_ports reverse]
# set_property IOSTANDARD LVCMOS33 [get_ports reverse]

# #led 0
# set_property PACKAGE_PIN U16 [get_ports recv_done]
# set_property IOSTANDARD LVCMOS33 [get_ports recv_done]

# #led 1
# set_property PACKAGE_PIN E19 [get_ports send_done]
# set_property IOSTANDARD LVCMOS33 [get_ports send_done]


# #UART
# set_property PACKAGE_PIN B18 [get_ports Rx_Serial]
# set_property PACKAGE_PIN A18 [get_ports Tx_Serial]

# set_property IOSTANDARD LVCMOS33 [get_ports Rx_Serial]
# set_property IOSTANDARD LVCMOS33 [get_ports Tx_Serial]

create_clock -period 10.000 -name SIM_CLK -waveform {0.000 5.000} [get_ports clk]