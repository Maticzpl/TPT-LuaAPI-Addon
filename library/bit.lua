---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- The Bit API provides functions for performing bitwise operations on integer numbers, the Bit API is from the [LuaJIT BitOp library](http://bitop.luajit.org/index.html), documentation is copied from [here](http://bitop.luajit.org/api.html)<br>
-- If you are unfamiliar with bitwise operations, you may want to check the Wikipedia page on the subject: [http://en.wikipedia.org/wiki/Bitwise_operation](http://en.wikipedia.org/wiki/Bitwise_operation)
bit = {}

--```
--bit.tobit(number input)
--```
-- Turns a number into something usable by the rest of the binary utility functions.<br>
-- It converts the number into a better form (what C deems to be a signed 32-bit int) to be used by the other bit functions. If you call one of the functions below yourself however, you do not need to use this function, as the below functions already use this in their code.
-- **Examples:**
--```
-- bit.tobit(100) --> 100
-- bit.tobit(-100) --> -100
-- bit.tobit(2147483647) --> bit.tobit(2^31 - 1) = 2147483647
-- bit.tobit(2147483648) --> bit.tobit(2^31) = -2147483648
--```
---@param input integer
---@return integer
function bit.tobit(input) end

--```
--bit.tohex(number input, number length)
--```
-- By default, length is 8, if you leave it out.<br>
-- Converts its first argument to a hexadecimal representation. Returns a string.<br>
--
-- How many hexadecimal digits to end up with is specified by the length argument. The length argument can also be negative, which specifies that the end result should have all-caps letters instead of small letters.
-- **Examples:**
--```
-- bit.tohex(1) --> "00000001"
-- bit.tohex(0xdeadbeef) --> "deadbeef"
-- bit.tohex(15, 2) --> "0f"
-- bit.tohex(0xdeadbeef, 2) --> "ef"
-- bit.tohex(0xdeadbeef, -4) --> "BEEF"
-- bit.tohex(0xdeadbeef, 25) --> "deadbeef"
--```
---@param input integer
---@param length integer?
---@return string
function bit.tohex(input, length) end

--```
--bit.bnot(number input)
--```
--Returns the bitwise NOT from its argument.<br>
--What happens during a bitwise NOT looks kinda like this: you start off with a value like 25 (::00011001) and you flip every bit specially and return the value, so...
-- **Example:**
--```
-- ~ 0000 0000  0000 0000  0000 0000  0001 1001
-- = 1111 1111  1111 1111  1111 1111  1110 0110
--```
---@param input integer
---@return integer
function bit.bnot(input) end

--```
--bit.band(number input, [number input...])
--```
--Returns the binary AND of all its arguments combined.<br>
--A binary AND is an operation that requires two numbers: the only bits that remain in the return value are ones that occur in both of the numbers. This is an easy way to pick out a single byte from a "bit string" - an integer that is actually used as a row of bits that can be used as boolean values. You can then store 32 booleans in a single int, whereas usually a single boolean is a single int!
-- **Example:**
--```
-- :: 0001 1001 &
-- :: 0011 0011 &
-- :: 0001 1010
--  = 0001 0000
--```
---@param ... integer
---@return integer
function bit.band(...) end

--```
--bit.bor(number input, [number input...])
--```
--Returns the binary inclusive OR of all its arguments combined.<br>
--Binary OR is really simple: if one of the arguments has a bit there, then the end result has a bit there too. This is also a simple way to deal with flags - you'll know that a bit will be turned on if you pass it through a binary OR. Binary OR happens like so:
-- **Example:**
--```
-- :: 0001 1001 |
-- :: 0011 1101 |
-- :: 0100 1000
--  = 0111 1101
--```

---@param ... integer
---@return integer
function bit.bor(...) end

--```
--bit.xor(number input, [number input...])
--```
--Returns the binary exclusive OR of all its arguments combined.<br>
--Binary exclusive OR or XOR for short is interesting: the end result's bit only gets toggled on when only one of the arguments has this bit toggled on. For flags, you can utilize it to toggle a bit - if it's on it will be off and if it's off it'll be on.
-- **Example:**
--```
-- :: 0011 0011 ^
-- :: 0010 1001 ^
-- :: 1100 1100
--  = 1101 0110
--```
---@param ... integer
---@return integer
function bit.xor(...) end

--```
--bit.lshift(number input, number shift)
--```
-- Shifts the input bits to the left by (shift) bits, replacing empty cells with 0 and discarding overflowing cells.<br>
-- Left shifting is something really easy to imagine: every bit just gets moved once (or more) to the left and the ends are replaced with 0. If you have a bit at the far left end it gets eaten and is lost forever. Not to worry usually though.<br>
-- Another great utilization of left shifting is that it's a really quick way of multiplying a number by two for some times. Shifting to the left by two is the same as multiplying a number by four.<br>
--```
-- :: 0000 0010 << 2
--  = 0000 1000
--```
-- **Examples:**
--```
-- bit.lshift(2, 2) --> 8
-- bit.lshift(2, 34) --> 8
--```
-- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
---@param input integer
---@param shift integer
---@return integer
function bit.lshift(input, shift) end

-- ```
-- bit.rshift(number input, number shift)
-- ```
-- Shifts the input bits to the right by (shift) bits, replacing empty cells with 0 and discarding overflowing cells.<br>
-- Right shifting is something really easy to imagine: every bit just gets moved once (or more) to the right and the ends are replaced with 0. If you have a bit at the far right end it gets eaten and is lost forever. Not to worry usually though.<br>
-- Another great utilization of right shifting is that it's a really quick way of dividing a number by two for some times. Shifting to the right by two is the same as dividing a number by four. Note that this will also move the sign bit. Which is what arithmetic right shift does not in fact do.
-- ```
--   1111 1111 :: >> 2
-- = 0011 1111  1100 0000 ::
-- ```
-- **Examples:**
-- ```
-- bit.rshift(-2, 5) --> 134217727
-- bit.rshift(4, 1) --> 2
-- bit.rshift(4, 33) --> 2<br>
-- ```
-- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
---@param input integer
---@param shift integer
---@return integer
function bit.rshift(input, shift) end

-- ```
-- bit.arshift(number input, number shift)
-- ```
-- Shifts the input bits to the right by (shift) bits, copying over the sign bit for the new bits added from the left.<br>
-- So the solution to our right shifting problem is that we need to add ones instead of zeros to the left side if we shift from the right. This keeps the sign right in place and still allows us to shift all we want.<br>
-- ```
--   1001 1001  0000 0000 :: >>> 2
-- = 1110 0110  0100 0000 ::
-- ```
-- Examples:
-- ```
-- bit.arshift(-4, 1) --> -2
-- bit.arshift(-32, 5) --> -1
-- bit.arshift(32, 5) --> 1
-- ```
-- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.<br>
---@param input integer
---@param shift integer
---@return integer
function bit.arshift(input, shift) end

-- ```
-- bit.rol(number input, number bits)
-- ```
-- ```
-- bit.ror(number input, number bits)
-- ```
-- Exactly like bit shifting, except it copies the bits from the right to the bits on the left instead of just feasting upon them.
-- ```
-- :: 0000 1111 ROR 2
--  = 1100 0000 :: 0000 0011
-- :: 1100 0011 1100 0011 ROR 2
--  = 1111 0000 1111 0000<br>
-- ```
-- Important note: the rotation count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
---@param input integer
---@param bits integer
---@return integer
function bit.rol(input, bits) end
-- ```
-- bit.rol(number input, number bits)
-- ```
-- ```
-- bit.ror(number input, number bits)
-- ```
-- Exactly like bit shifting, except it copies the bits from the right to the bits on the left instead of just feasting upon them.
-- ```
-- :: 0000 1111 ROR 2
--  = 1100 0000 :: 0000 0011
-- :: 1100 0011 1100 0011 ROR 2
--  = 1111 0000 1111 0000<br>
-- ```
-- Important note: the rotation count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
---@param input integer
---@param bits integer
---@return integer
function bit.ror(input, bits) end

-- ```
-- bit.bswap(number input)
-- ```
-- Swaps the byte order of the argument.
--<br>
-- In a few places, TPT uses weird reverse-byte-order numbers, such as TPT saves in the OPS 1 format. This function makes things easier and just flips the bytes for you.
-- ```
--   0110 1010 0101 1001
-- = 1001 0101 1010 0110
-- ```
-- Examples:
-- ```
-- bit.tohex(bit.bswap(0x01020304)) --> "04030201"
-- bit.tohex(bit.bswap(0xdeadbeef), -8) --> "EFBEADDE"
-- bit.bswap(5) --> 83886080
-- ```
---@param input integer
---@return integer
function bit.bswap(input) end
