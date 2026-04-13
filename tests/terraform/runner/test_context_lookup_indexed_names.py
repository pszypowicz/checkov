from checkov.terraform.runner import _strip_foreach_suffix


def test_strip_foreach_suffix_unchanged():
    assert _strip_foreach_suffix("vault") == "vault"


def test_strip_foreach_suffix_count_index():
    assert _strip_foreach_suffix("vault[0]") == "vault"
    assert _strip_foreach_suffix("vault[42]") == "vault"


def test_strip_foreach_suffix_string_key():
    assert _strip_foreach_suffix('vault["key"]') == "vault"
    assert _strip_foreach_suffix("vault[my-key]") == "vault"


def test_strip_foreach_suffix_preserves_inner_brackets():
    # "[" not terminal - shouldn't strip
    assert _strip_foreach_suffix("foo[bar]baz") == "foo[bar]baz"
