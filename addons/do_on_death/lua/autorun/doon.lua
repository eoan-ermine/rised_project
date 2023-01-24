-- "addons\\do_on_death\\lua\\autorun\\doon.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------------------------------------------
-- "DO ON" Framework by Kazaam
-- Because lua needs these usefull simple functions
------------------------------------------------------

--
-- Returns if the element is in the specified table.
--
function table.contains(table, element)

  for _, value in pairs(table) do

    if value == element then
      return true
    end

  end

  return false

end


--
-- Returns the number of items in the specified table.
--
function table.count(table)

    local count = 0

    for _, val in pairs(table) do
        count = count + 1
    end

    return count

end
