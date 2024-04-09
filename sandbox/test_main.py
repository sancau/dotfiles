from main import Controller, foo


def test_nothing():
    assert foo(2) == 4


def test_controller():
    c = Controller(42)

    assert c.test() == 42
