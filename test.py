class A:
    def __init__(self, a):
        print("test")
        self.a = a + 2

    def foo(self):
        return self.a * 42


def test_a():
    a = A(40)  # noqaj F841
    ...
