if CLIENT then
    --- Returns local player language. Client function.
    ---@return string
    function GetLocalLang()
        return Format(GetConVar('n_lang'):GetString())
    end
end