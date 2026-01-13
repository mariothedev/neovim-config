local ls = require("luasnip")

local python_snippets = {
    -- Basic Control Flow
    -- While loop
    ls.snippet("while", {
        ls.text_node("while "),
        ls.insert_node(1, "condition"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "pass"),
    }),

    -- For loop
    ls.snippet("for", {
        ls.text_node("for "),
        ls.insert_node(1, "item"),
        ls.text_node(" in "),
        ls.insert_node(2, "iterable"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- For loop with enumerate
    ls.snippet("fore", {
        ls.text_node("for "),
        ls.insert_node(1, "i"),
        ls.text_node(", "),
        ls.insert_node(2, "item"),
        ls.text_node(" in enumerate("),
        ls.insert_node(3, "iterable"),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
    }),

    -- For loop with range
    ls.snippet("forr", {
        ls.text_node("for "),
        ls.insert_node(1, "i"),
        ls.text_node(" in range("),
        ls.insert_node(2, "n"),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- If statement
    ls.snippet("if", {
        ls.text_node("if "),
        ls.insert_node(1, "condition"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "pass"),
    }),

    -- If-else statement
    ls.snippet("ife", {
        ls.text_node("if "),
        ls.insert_node(1, "condition"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "pass"),
        ls.text_node({"", "else:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- If-elif-else statement
    ls.snippet("ifel", {
        ls.text_node("if "),
        ls.insert_node(1, "condition"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "pass"),
        ls.text_node({"", "elif "}),
        ls.insert_node(3, "condition"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
        ls.text_node({"", "else:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(5, "pass"),
    }),

    -- Match statement (Python 3.10+)
    ls.snippet("match", {
        ls.text_node("match "),
        ls.insert_node(1, "value"),
        ls.text_node(":"),
        ls.text_node({"", "    case "}),
        ls.insert_node(2, "pattern"),
        ls.text_node(":"),
        ls.text_node({"", "        "}),
        ls.insert_node(3, "pass"),
        ls.text_node({"", "    case _:"}),
        ls.text_node({"", "        "}),
        ls.insert_node(4, "pass"),
    }),

    -- Function Definitions
    -- Basic function
    ls.snippet("def", {
        ls.text_node("def "),
        ls.insert_node(1, "function_name"),
        ls.text_node("("),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Function with return
    ls.snippet("defr", {
        ls.text_node("def "),
        ls.insert_node(1, "function_name"),
        ls.text_node("("),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "# Implementation"),
        ls.text_node({"", "    return "}),
        ls.insert_node(4, "result"),
    }),

    -- Function with type hints
    ls.snippet("deft", {
        ls.text_node("def "),
        ls.insert_node(1, "function_name"),
        ls.text_node("("),
        ls.insert_node(2, "param: type"),
        ls.text_node(") -> "),
        ls.insert_node(3, "ReturnType"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
    }),

    -- Async function
    ls.snippet("adef", {
        ls.text_node("async def "),
        ls.insert_node(1, "function_name"),
        ls.text_node("("),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Lambda function
    ls.snippet("lambda", {
        ls.text_node("lambda "),
        ls.insert_node(1, "x"),
        ls.text_node(": "),
        ls.insert_node(2, "x"),
    }),

    -- Exception Handling
    -- Try-except
    ls.snippet("try", {
        ls.text_node("try:"),
        ls.text_node({"", "    "}),
        ls.insert_node(1, "pass"),
        ls.text_node({"", "except "}),
        ls.insert_node(2, "Exception"),
        ls.text_node(" as "),
        ls.insert_node(3, "e"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
    }),

    -- Try-except-finally
    ls.snippet("tryf", {
        ls.text_node("try:"),
        ls.text_node({"", "    "}),
        ls.insert_node(1, "pass"),
        ls.text_node({"", "except "}),
        ls.insert_node(2, "Exception"),
        ls.text_node(" as "),
        ls.insert_node(3, "e"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
        ls.text_node({"", "finally:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(5, "pass"),
    }),

    -- Try-except-else
    ls.snippet("trye", {
        ls.text_node("try:"),
        ls.text_node({"", "    "}),
        ls.insert_node(1, "pass"),
        ls.text_node({"", "except "}),
        ls.insert_node(2, "Exception"),
        ls.text_node(" as "),
        ls.insert_node(3, "e"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
        ls.text_node({"", "else:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(5, "pass"),
    }),

    -- Raise exception
    ls.snippet("raise", {
        ls.text_node("raise "),
        ls.insert_node(1, "Exception"),
        ls.text_node("("),
        ls.insert_node(2, '"Error message"'),
        ls.text_node(")"),
    }),

    -- Classes
    -- Basic class
    ls.snippet("class", {
        ls.text_node("class "),
        ls.insert_node(1, "ClassName"),
        ls.text_node(":"),
        ls.text_node({"", "    def __init__(self"}),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "        "}),
        ls.insert_node(3, "pass"),
    }),

    -- Class with inheritance
    ls.snippet("classi", {
        ls.text_node("class "),
        ls.insert_node(1, "ClassName"),
        ls.text_node("("),
        ls.insert_node(2, "BaseClass"),
        ls.text_node("):"),
        ls.text_node({"", "    def __init__(self"}),
        ls.insert_node(3),
        ls.text_node("):"),
        ls.text_node({"", "        super().__init__("}),
        ls.insert_node(4),
        ls.text_node(")"),
        ls.text_node({"", "        "}),
        ls.insert_node(5, "pass"),
    }),

    -- Dataclass (Python 3.7+)
    ls.snippet("dataclass", {
        ls.text_node("from dataclasses import dataclass"),
        ls.text_node({"", "", "@dataclass"}),
        ls.text_node({"", "class "}),
        ls.insert_node(1, "ClassName"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "field: type"),
    }),

    -- Method
    ls.snippet("method", {
        ls.text_node("def "),
        ls.insert_node(1, "method_name"),
        ls.text_node("(self"),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Static method
    ls.snippet("smethod", {
        ls.text_node("@staticmethod"),
        ls.text_node({"", "def "}),
        ls.insert_node(1, "method_name"),
        ls.text_node("("),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Class method
    ls.snippet("cmethod", {
        ls.text_node("@classmethod"),
        ls.text_node({"", "def "}),
        ls.insert_node(1, "method_name"),
        ls.text_node("(cls"),
        ls.insert_node(2),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Property
    ls.snippet("property", {
        ls.text_node("@property"),
        ls.text_node({"", "def "}),
        ls.insert_node(1, "property_name"),
        ls.text_node("(self):"),
        ls.text_node({"", "    return "}),
        ls.insert_node(2, "self._property_name"),
    }),

    -- Property setter
    ls.snippet("setter", {
        ls.text_node("@"),
        ls.insert_node(1, "property_name"),
        ls.text_node(".setter"),
        ls.text_node({"", "def "}),
        ls.insert_node(2, "property_name"),
        ls.text_node("(self, value):"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "self._property_name = value"),
    }),

    -- Context Managers
    -- With statement
    ls.snippet("with", {
        ls.text_node("with "),
        ls.insert_node(1, "expression"),
        ls.text_node(" as "),
        ls.insert_node(2, "var"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- With open file
    ls.snippet("withopen", {
        ls.text_node("with open("),
        ls.insert_node(1, '"filename"'),
        ls.text_node(", "),
        ls.insert_node(2, '"r"'),
        ls.text_node(") as "),
        ls.insert_node(3, "f"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "content = f.read()"),
    }),

    -- Imports
    -- Import
    ls.snippet("imp", {
        ls.text_node("import "),
        ls.insert_node(1, "module"),
    }),

    -- From import
    ls.snippet("from", {
        ls.text_node("from "),
        ls.insert_node(1, "module"),
        ls.text_node(" import "),
        ls.insert_node(2, "name"),
    }),

    -- Common imports
    ls.snippet("impnp", {
        ls.text_node("import numpy as np"),
    }),

    ls.snippet("imppd", {
        ls.text_node("import pandas as pd"),
    }),

    ls.snippet("impplt", {
        ls.text_node("import matplotlib.pyplot as plt"),
    }),

    -- Decorators
    -- Decorator
    ls.snippet("dec", {
        ls.text_node("def "),
        ls.insert_node(1, "decorator"),
        ls.text_node("(func):"),
        ls.text_node({"", "    def wrapper(*args, **kwargs):"}),
        ls.text_node({"", "        "}),
        ls.insert_node(2, "# Before function call"),
        ls.text_node({"", "        result = func(*args, **kwargs)"}),
        ls.text_node({"", "        "}),
        ls.insert_node(3, "# After function call"),
        ls.text_node({"", "        return result"}),
        ls.text_node({"", "    return wrapper"}),
    }),

    -- Main Block
    -- If main
    ls.snippet("main", {
        ls.text_node('if __name__ == "__main__":'),
        ls.text_node({"", "    "}),
        ls.insert_node(1, "main()"),
    }),

    -- Assertions and Testing
    -- Assert
    ls.snippet("assert", {
        ls.text_node("assert "),
        ls.insert_node(1, "condition"),
        ls.text_node(", "),
        ls.insert_node(2, '"Error message"'),
    }),

    -- Unit test
    ls.snippet("test", {
        ls.text_node("def test_"),
        ls.insert_node(1, "function_name"),
        ls.text_node("():"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "# Arrange"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "# Act"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "# Assert"),
    }),

    -- Pytest fixture
    ls.snippet("fixture", {
        ls.text_node("@pytest.fixture"),
        ls.text_node({"", "def "}),
        ls.insert_node(1, "fixture_name"),
        ls.text_node("():"),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "# Setup"),
        ls.text_node({"", "    yield "}),
        ls.insert_node(3, "value"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "# Teardown"),
    }),

    -- Comprehensions
    -- List comprehension
    ls.snippet("lc", {
        ls.text_node("["),
        ls.insert_node(1, "expr"),
        ls.text_node(" for "),
        ls.insert_node(2, "item"),
        ls.text_node(" in "),
        ls.insert_node(3, "iterable"),
        ls.text_node("]"),
    }),

    -- List comprehension with condition
    ls.snippet("lci", {
        ls.text_node("["),
        ls.insert_node(1, "expr"),
        ls.text_node(" for "),
        ls.insert_node(2, "item"),
        ls.text_node(" in "),
        ls.insert_node(3, "iterable"),
        ls.text_node(" if "),
        ls.insert_node(4, "condition"),
        ls.text_node("]"),
    }),

    -- Dictionary comprehension
    ls.snippet("dc", {
        ls.text_node("{"),
        ls.insert_node(1, "key"),
        ls.text_node(": "),
        ls.insert_node(2, "value"),
        ls.text_node(" for "),
        ls.insert_node(3, "item"),
        ls.text_node(" in "),
        ls.insert_node(4, "iterable"),
        ls.text_node("}"),
    }),

    -- Set comprehension
    ls.snippet("sc", {
        ls.text_node("{"),
        ls.insert_node(1, "expr"),
        ls.text_node(" for "),
        ls.insert_node(2, "item"),
        ls.text_node(" in "),
        ls.insert_node(3, "iterable"),
        ls.text_node("}"),
    }),

    -- Generator expression
    ls.snippet("ge", {
        ls.text_node("("),
        ls.insert_node(1, "expr"),
        ls.text_node(" for "),
        ls.insert_node(2, "item"),
        ls.text_node(" in "),
        ls.insert_node(3, "iterable"),
        ls.text_node(")"),
    }),

    -- Async/Await
    -- Await
    ls.snippet("await", {
        ls.text_node("await "),
        ls.insert_node(1, "async_function()"),
    }),

    -- Async with
    ls.snippet("asyncwith", {
        ls.text_node("async with "),
        ls.insert_node(1, "async_context_manager"),
        ls.text_node(" as "),
        ls.insert_node(2, "var"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Async for
    ls.snippet("asyncfor", {
        ls.text_node("async for "),
        ls.insert_node(1, "item"),
        ls.text_node(" in "),
        ls.insert_node(2, "async_iterable"),
        ls.text_node(":"),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "pass"),
    }),

    -- Logging
    -- Basic logging
    ls.snippet("log", {
        ls.text_node("import logging"),
        ls.text_node({"", "", "logging.basicConfig(level=logging.INFO)"}),
        ls.text_node({"", "logger = logging.getLogger(__name__)"}),
    }),

    -- Log debug
    ls.snippet("logd", {
        ls.text_node("logger.debug("),
        ls.insert_node(1, '"Debug message"'),
        ls.text_node(")"),
    }),

    -- Log info
    ls.snippet("logi", {
        ls.text_node("logger.info("),
        ls.insert_node(1, '"Info message"'),
        ls.text_node(")"),
    }),

    -- Log warning
    ls.snippet("logw", {
        ls.text_node("logger.warning("),
        ls.insert_node(1, '"Warning message"'),
        ls.text_node(")"),
    }),

    -- Log error
    ls.snippet("loge", {
        ls.text_node("logger.error("),
        ls.insert_node(1, '"Error message"'),
        ls.text_node(")"),
    }),

    -- Type Hints
    -- Type alias
    ls.snippet("typealias", {
        ls.text_node("type "),
        ls.insert_node(1, "AliasName"),
        ls.text_node(" = "),
        ls.insert_node(2, "Type"),
    }),

    -- TypeVar
    ls.snippet("typevar", {
        ls.text_node("from typing import TypeVar"),
        ls.text_node({"", "", ""}),
        ls.insert_node(1, "T"),
        ls.text_node(" = TypeVar('"),
        ls.insert_node(2, "T"),
        ls.text_node("')"),
    }),

    -- Docstrings
    -- Function docstring
    ls.snippet("docf", {
        ls.text_node('"""'),
        ls.insert_node(1, "Brief description."),
        ls.text_node({"", "", "Args:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "param: Description"),
        ls.text_node({"", "", "Returns:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(3, "Description of return value"),
        ls.text_node({"", '"""'}),
    }),

    -- Class docstring
    ls.snippet("docc", {
        ls.text_node('"""'),
        ls.insert_node(1, "Brief description."),
        ls.text_node({"", "", "Attributes:"}),
        ls.text_node({"", "    "}),
        ls.insert_node(2, "attribute: Description"),
        ls.text_node({"", '"""'}),
    }),

    -- Module docstring
    ls.snippet("docm", {
        ls.text_node('"""'),
        ls.insert_node(1, "Module description."),
        ls.text_node({"", "", "This module provides:"}),
        ls.text_node({"", "- "}),
        ls.insert_node(2, "Feature 1"),
        ls.text_node({"", "- "}),
        ls.insert_node(3, "Feature 2"),
        ls.text_node({"", '"""'}),
    }),

    -- Common Patterns
    -- Enumerate with start
    ls.snippet("enumstart", {
        ls.text_node("for "),
        ls.insert_node(1, "i"),
        ls.text_node(", "),
        ls.insert_node(2, "item"),
        ls.text_node(" in enumerate("),
        ls.insert_node(3, "iterable"),
        ls.text_node(", start="),
        ls.insert_node(4, "1"),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(5, "pass"),
    }),

    -- Zip
    ls.snippet("zip", {
        ls.text_node("for "),
        ls.insert_node(1, "a, b"),
        ls.text_node(" in zip("),
        ls.insert_node(2, "list1"),
        ls.text_node(", "),
        ls.insert_node(3, "list2"),
        ls.text_node("):"),
        ls.text_node({"", "    "}),
        ls.insert_node(4, "pass"),
    }),

    -- Print f-string
    ls.snippet("printf", {
        ls.text_node("print(f"),
        ls.insert_node(1, '"{variable=}"'),
        ls.text_node(")"),
    }),

    -- Return None
    ls.snippet("retnone", {
        ls.text_node("return None"),
    }),

    -- Return True/False
    ls.snippet("rett", {
        ls.text_node("return True"),
    }),

    ls.snippet("retf", {
        ls.text_node("return False"),
    }),

    -- Continue
    ls.snippet("cont", {
        ls.text_node("continue"),
    }),

    -- Break
    ls.snippet("break", {
        ls.text_node("break"),
    }),

    -- Pass
    ls.snippet("pass", {
        ls.text_node("pass"),
    }),
}

return python_snippets
