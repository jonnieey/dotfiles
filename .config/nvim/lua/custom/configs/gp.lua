require('gp').setup {
  cmd_prefix = 'Gp',
  openai_api_key = os.getenv 'OPENAI_API_KEY',
  providers = {
    openai = {
      endpoint = 'https://api.openai.com/v1/chat/completions',
    },
  },
  hooks = {
    Complete = function(gp, params)
      local template = [[
        I have the following code from {{filename}}:

        ```{{filetype}}
        {{selection}}
        ```

        Please finish the code above carefully and logically.
        Respond just with the snippet of code that should be inserted."
        ]]
      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.append, agent, template, nil, nil)
    end,
    CompleteFullContext = function(gp, params)
      local template = [[
        I have the following code from {{filename}} and other realted files:

				```{{filetype}}
				{{multifilecontent}}
				```

				Please look at the following section specifically:
        ```{{filetype}}
        {{selection}}
        ```

        Please finish the code above carefully and logically.
        Respond just with the snippet of code that should be inserted."
        ]]
      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.append, agent, template, nil, nil)
    end,
    Explain = function(gp, params)
      local template = [[
        Your task is to take the code snippet from {{filename}} and explain it with gradually increasing complexity.
        Break down the code's functionality, purpose, and key components.
        The goal is to help the reader understand what the code does and how it works.

        ```{{filetype}}
        {{selection}}
        ```

        Use the markdown format with codeblocks and inline code.
        Explanation of the code above:
        ]]
      local agent = gp.get_chat_agent()
      -- gp.info('Explaining selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.popup, agent, template, nil, nil)
    end,
    FixBugs = function(gp, params)
      local template = [[
        You are an expert in {{filetype}}.
        Fix bugs in the below code from {{filename}} carefully and logically:
        Your task is to analyze the provided {{filetype}} code snippet, identify
        any bugs or errors present, and provide a corrected version of the code
        that resolves these issues. Explain the problems you found in the
        original code and how your fixes address them. The corrected code should
        be functional, efficient, and adhere to best practices in
        {{filetype}} programming.

        ```{{filetype}}
        {{selection}}
        ```

        Fixed code:
        ]]
      local agent = gp.get_command_agent()
      -- gp.info('Fixing bugs in selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.vnew, agent, template, nil, nil)
    end,
    Optimize = function(gp, params)
      local template = [[
        You are an expert in {{filetype}}.
        Your task is to analyze the provided {{filetype}} code snippet and
        suggest improvements to optimize its performance. Identify areas
        where the code can be made more efficient, faster, or less
        resource-intensive. Provide specific suggestions for optimization,
        along with explanations of how these changes can enhance the code's
        performance as in-line comments. The optimized code should maintain
        the same functionality as the original code while demonstrating
        improved efficiency.

        ```{{filetype}}
        {{selection}}
        ```

        Optimized code:
        ]]
      local agent = gp.get_command_agent()
      -- gp.info('Optimizing selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.vnew, agent, template, nil, nil)
    end,
    UnitTests = function(gp, params)
      local template = [[
        I have the following code from {{filename}}:

        ```{{filetype}}
        {{selection}}
        ```

        Please respond by writing table driven unit tests for the code above.
        ]]
      local agent = gp.get_command_agent()
      -- gp.info('Creating unit tests for selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.enew, agent, template, nil, nil)
    end,
    Debug = function(gp, params)
      local template = [[
        I want you to act as {{filetype}} expert.
        Review the following code, carefully examine it, and report potential
        bugs and edge cases alongside solutions to resolve them.
        Keep your explanation short and to the point:

        ```{{filetype}}
        {{selection}}
        ```
        ]]
      local agent = gp.get_chat_agent()
      -- gp.info('Debugging selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.vnew, agent, template, nil, nil)
    end,
    -- CommitMsg = function(gp, params)
    --   local futils = require 'parrot.file_utils'
    --   if futils.find_git_root() == '' then
    --     gp.warning 'Not in a git repository'
    --     return
    --   else
    --     local template = [[
    -- 	I want you to act as a commit message generator. I will provide you
    -- 	with information about the task and the prefix for the task code, and
    -- 	I would like you to generate an appropriate commit message using the
    -- 	conventional commit format. Do not write any explanations or other
    -- 	words, just reply with the commit message.
    -- 	Start with a short headline as summary but then list the individual
    -- 	changes in more detail.
    --
    -- 	Here are the changes that should be considered by this message:
    -- 	]] .. vim.fn.system 'git diff --no-color --no-ext-diff --staged'
    --     local agent = gp.get_command_agent()
    --     gp.Prompt(params, gp.ui.Target.append, nil, agent.model, template, agent.system_prompt, agent.provider)
    --   end
    -- end,
    DocStr = function(gp, params)
      local template = [[
            I want you to act as {{filetype}} expert.
             An elaborate, high quality docstring for the above function:

             Writing a good docstring

             This is an example of writing a really good docstring that follows a best practice for {{filetype}} code. Attention is paid to detailing things like
               * parameter and return types (if applicable)
               * any errors that might be raised or returned, depending on the language

             NB: DO NOT CHANGE ANY CODE PROVIDED AND BE CONCISE

             I received the following code:

             ```{{filetype}}

             {{selection}}
             ```

             The code with a really good docstring added is below:

             ```{{filetype}}",

        ]]
      local agent = gp.get_chat_agent()
      -- gp.info('Debugging selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.vnew, agent, template, nil, nil)
    end,
    FunctionalTests = function(gp, params)
      local template = [[
        I have the following code from {{filename}}:

        ```{{filetype}}
        {{selection}}
        ```

        Please respond by writing functional tests for the code above.
        ]]
      local agent = gp.get_command_agent()
      -- gp.info('Creating unit tests for selection with agent: ' .. agent.name)
      gp.Prompt(params, gp.Target.enew, agent, template, nil, nil)
    end,
  },
}
