--
-- (C) 2019 - ntop.org
--

local flow_consts = require("flow_consts")
local user_scripts = require("user_scripts")

-- #################################################################

local script = {
  -- NOTE: hooks defined below
  hooks = {},

  gui = {
    i18n_title = "flow_callbacks_config.remote_to_remote",
    i18n_description = "flow_callbacks_config.remote_to_remote_description",
    input_builder = user_scripts.flow_checkbox_input_builder,
  }
}

-- #################################################################

function script.hooks.protocolDetected(params)
  local info = params.flow_info

  if((not info["cli.localhost"]) and (not info["srv.localhost"])) then
    local unicast_info = flow.getUnicastInfo()

    if((not unicast_info["cli.broadmulticast"]) and (not unicast_info["srv.broadmulticast"])) then
      flow.triggerStatus(flow_consts.status_types.status_remote_to_remote.status_id)
    end
  end
end

-- #################################################################

return script
