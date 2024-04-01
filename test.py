from collections import Counter

c = Counter("hello, world")
most_common = c.most_common()

print(Counter("asdfasdfdas asdfsadfasd mEfasdfdasf").most_common())

[i for i in range(10)]

######################

import asyncio


async def job():
    print("tick")
    await asyncio.sleep(1)


asyncio.create_task(job())

######################

xs = [i for i in range(123)]

xs[122]
