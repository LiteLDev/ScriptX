add_rules("mode.debug", "mode.release")

add_repositories("liteldev-repo https://github.com/LiteLDev/xmake-repo.git")
add_requires("lua v5.4.6", {configs={shared=true}})
add_requires("quickjs 2022-03-07", {configs={shared=true}})
add_requires("python 3.10.11", {configs={shared=true}})
add_requires("node v16.16.0", {configs={shared=true}})

option("backend")
    set_default("Lua")
    set_values("Lua", "QuickJs", "Python", "V8")

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

    elseif is_config("backend", "Python") then
        add_defines(
            "SCRIPTX_BACKEND_PYTHON",
            "SCRIPTX_BACKEND_TRAIT_PREFIX=../backend/Python/trait/Trait"
        )
        add_files(
            "backend/Python/**.cc",
            "backend/Python/**.c"
        )
        add_packages(
            "python"
        )

    elseif is_config("backend", "V8") then
        add_defines(
            "SCRIPTX_BACKEND_V8",
            "SCRIPTX_BACKEND_TRAIT_PREFIX=../backend/V8/trait/Trait"
        )
        add_files(
            "backend/V8/**.cc"
        )
        add_packages(
            "node"
        )

    end
