add_rules("mode.debug", "mode.release")

add_repositories("liteldev-repo https://github.com/LiteLDev/xmake-repo.git")
add_requires("lua v5.4.6", {configs={shared=true}})
add_requires("quickjs 2022-03-07", {configs={shared=true}})

if not has_config("vs_runtime") then
    set_runtimes("MD")
end

option("backend")
    set_default("Lua")
    set_values("Lua", "QuickJs")

target("ScriptX")
    add_files(
        "src/**.cc"
    )
    add_headerfiles(
        "(**.h)",
        "(**.hpp)"
    )
    add_includedirs(
        "src/include/"
    )
    set_kind("static")
    set_languages("cxx20")

    if is_config("backend", "Lua") then
        add_defines(
            "SCRIPTX_BACKEND_LUA",
            "SCRIPTX_BACKEND_TRAIT_PREFIX=../backend/Lua/trait/Trait"
        )
        add_files(
            "backend/Lua/**.cc"
        )
        add_packages(
            "lua"
        )

    elseif is_config("backend", "QuickJs") then
        add_defines(
            "SCRIPTX_BACKEND_QUICKJS",
            "SCRIPTX_BACKEND_TRAIT_PREFIX=../backend/QuickJs/trait/Trait"
        )
        add_files(
            "backend/QuickJs/**.cc"
        )
        add_packages(
            "quickjs"
        )
    end
