# Bash completion for rabbitvcs modules
# ---------------------------------------------------------------------------
_rabitvcs_opts()
{
    rabbitvcs 2>&1 |
    sed '
        5,/^$/!d
        s/,\s*/,/g
    ' |
    awk -F',' '
        {
            for (i = 1; i < NF; i++) { arr[length(arr)] = $i }
        }
        END{
            for (e in arr) { print arr[e] }
        }' | 
    grep "^$2.*";
}
complete -C _rabitvcs_opts -o default rabbitvcs

# ---------------------------------------------------------------------------


# ANSI colours
# ---------------------------------------------------------------------------
__complete_ansi_color()
{
   echo "black red green brown blue purple cyan light_gray dark_gray light_red light_green yellow light_blue light_purple light_cyan white none" | 
   tr ' ' '\n' | grep "^$2.*"
}

link_complete_function ansi_color
link_complete_function ansi_color set_prompt_color
# ---------------------------------------------------------------------------

__complete_new()
{
   (builtin cd $SOURCE_TEMPLATES && ls) | grep "^$2.*"
}

link_complete_function new
