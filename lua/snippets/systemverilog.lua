local ls = require("luasnip")

-- This is a snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda

-- Repeats a node
-- rep(<position>)
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
--
-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {..nodes>})
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key



return {
    
    s("test", fmt("test {}", i(0, "expand"))),
    s("always",
        fmt([[
            {} begin
                {}
            end]], 
            {
                c(1, { sn(nil, fmt("always_ff @ (posedge {}, negedge {})", {i(1, "clk"), i(2, "rstn")})), t"always_comb", t"always_latch"}),
                i(0)
            })),

    -- The goal of this snippet is to dynamically create a clause for each of the enum states after you provide the expression
    s("fsm",
        fmt([[
        case({})
            {} : begin
                {}
            end
            default : begin
                
            end
        endcase]], 
            {
                i(1, "fsm_e"),
                i(2, "state0"),
                i(0),
            })),
    
    s("build_phase",
        fmt([[
            function void build_phase(uvm_phase phase);
                {}
                super.build_phase();
            endfunction : build_phase
        ]],
            {i(0)})
    ),
    s("connect_phase",
        fmt([[
            function void connect_phase(uvm_phase phase);
                {}
            endfunction : connect_phase
        ]],
            {i(0)})
    ),
    s("end_of_elaboration_phase",
        fmt([[
            function void end_of_elaboration_phase(uvm_phase phase);
                {}
            endfunction : end_of_elaboration_phase 
        ]],
            {i(0)})
    ),
    s("start_of_simulation_phase",
        fmt([[
            function void start_of_simulation_phase(uvm_phase phase);
                {}
            endfunction : start_of_simulation_phase 
        ]],
            {i(0)})
    ),
    s("run_phase",
        fmt([[
            task run_phase(uvm_phase phase);
                {}
            endtask : run_phase 
        ]],
            {i(0)})
    ),
    s("pre_reset_phase",
        fmt([[
            task pre_reset_phase(uvm_phase phase);
                {}
            endtask :pre_reset_phase 
        ]],
            {i(0)})
    ),
    s("reset_phase",
        fmt([[
            task reset_phase(uvm_phase phase);
                {}
            endtask : reset_phase 
        ]],
            {i(0)})
    ),
    s("post_reset_phase",
        fmt([[
            task post_reset_phase(uvm_phase phase);
                {}
            endtask : post_reset_phase 
        ]],
            {i(0)})
    ),
    s("pre_configure_phase",
        fmt([[
            task pre_configure_phase(uvm_phase phase);
                {}
            endtask : pre_configure_phase 
        ]],
            {i(0)})
    ),
    s("configure_phase",
        fmt([[
            task configure_phase(uvm_phase phase);
                {}
            endtask : configure_phase 
        ]],
            {i(0)})
    ),
    s("post_configure_phase",
        fmt([[
            task post_configure_phase(uvm_phase phase);
                {}
            endtask : post_configure_phase 
        ]],
            {i(0)})
    ),
    s("pre_main_phase",
        fmt([[
            task pre_main_phase(uvm_phase phase);
                {}
            endtask : pre_main_phase 
        ]],
            {i(0)})
    ),
    s("main_phase",
        fmt([[
            task main_phase(uvm_phase phase);
                {}
            endtask : main_phase
        ]],
            {i(0)})
    ),
    s("post_main_phase",
        fmt([[
            task post_main_phase(uvm_phase phase);
                {}
            endtask : post_main_phase 
        ]],
            {i(0)})
    ),
    s("pre_shutdown_phase",
        fmt([[
            task pre_shutdown_phase(uvm_phase phase);
                {}
            endtask : pre_shutdown_phase 
        ]],
            {i(0)})
    ),
    s("shutdown_phase",
        fmt([[
            task shutdown_phase(uvm_phase phase);
                {}
            endtask : shutdown_phase 
        ]],
            {i(0)})
    ),
    s("post_shutdown_phase",
        fmt([[
            task post_shutdown_phase(uvm_phase phase);
                {}
            endtask : post_shutdown_phase 
        ]],
            {i(0)})
    ),
    s("extract_phase",
        fmt([[
            function void extract_phase(uvm_phase phase);
                {}
            endfunction : extract_phase 
        ]],
            {i(0)})
    ),
    s("check_phase",
        fmt([[
            function void check_phase(uvm_phase phase);
                {}
            endfunction : check_phase 
        ]],
            {i(0)})
    ),
    s("report_phase",
        fmt([[
            function void report_phase(uvm_phase phase);
                {}
            endfunction : report_phase
        ]],
            {i(0)})
    ),
    s("final_phase",
        fmt([[
            function void final_phase(uvm_phase phase);
                {}
            endfunction : final_phase 
        ]],
            {i(0)})
    ),
}
