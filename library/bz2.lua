---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- TODO: Change enum to alias, move bz2 declaration below all @alias annotations

-- The `bz2` API provides access to the bzip2 library TPT bundles. It can be used for compressing and decompressing blocks of data, such as TPT saves.<br>
-- Only one-shot functionality is exposed because streaming functionality is only useful for tasks that are beyond the scope of this API.<br>
-- Unless stated otherwise, all functions raise errors if supplied with parameters that disagree with their descriptions. 
bz2 = {}

---@deprecated
--Compression OK
bz2.compressOk = 0

--Compression failed, ran out of memory
--### **REPLACED BY `bz2.COMPRESS_NOMEM`**
---@deprecated
bz2.compressNomem = 1

--Compression failed, maxSize limit exceeded
--### **REPLACED BY `bz2.COMPRESS_LIMIT`**
---@deprecated
bz2.compressLimit = 2

--Decompression OK
---@deprecated
bz2.decompressOk = 0

--Decompression failed, ran out of memory
--### **REPLACED BY `bz2.DECOMPRESS_NOMEM`**
---@deprecated
bz2.decompressNomem = 4

--Decompression failed, maxSize limit exceeded
--### **REPLACED BY `bz2.DECOMPRESS_LIMIT`**
---@deprecated
bz2.decompressLimit = 2

--Decompression failed, sourceData does not have bzip2 header and is likely not bzip2 data
--### **REPLACED BY `bz2.DECOMPRESS_TYPE`**
---@deprecated
bz2.decompressType = 3

--Decompression failed, sourceData is not valid bzip2 data
--### **REPLACED BY `bz2.DECOMPRESS_BAD`**
---@deprecated
bz2.decompressBad = 4

--### **REPLACED BY `bz2.DECOMPRESS_EOF`**
---@deprecated
bz2.decompressEof = 5

---@alias bz2CompressErr
---|`bz2.COMPRESS_NOMEM`
---|`bz2.COMPRESS_LIMIT`
---|nil

---@alias bz2DecompressErr
---|`bz2.DECOMPRESS_NOMEM`
---|`bz2.DECOMPRESS_LIMIT`
---|`bz2.DECOMPRESS_TYPE`
---|`bz2.DECOMPRESS_BAD`
---|`bz2.DECOMPRESS_EOF`
---|nil

--```
--compressedData, errCode, errStr = bz2.compress(data, [maxSize])
--```
--Compress data with bzip2 at compression level 9.<br>
--  - `data`: string, the data to be compressed<br>
--  - `maxSize`: number, upper limit on the length of `compressedData`; defaults to `0`, which means no limit<br>
--  - `compressedData`: string, the compressed data, or `nil` on error<br>
--  - `errCode`: `nil`, or one of the following values on error:<br>
--      - `bz2.COMPRESS_NOMEM`: out of memory, TPT will probably crash soon<br>
--      - `bz2.COMPRESS_LIMIT`: the length of `compressedData` would exceed `maxSize`<br>
--  - `errStr`: `nil`, or a human-friendly string that explains the error<br>
---@param sourceData string
---@param maxSize integer?
---@return string | nil, bz2CompressErr, string | nil
function bz2.compress(sourceData, maxSize) end

--```
--data, errCode, errStr = bz2.decompress(compressedData, [maxSize])
--```
--Decompress bzip2-compressed data.<br>
--  - `compressedData`: string, the compressed data<br>
--  - `maxSize`: number, upper limit on the length of data; defaults to 0, which means no limit<br>
--  - `data`: string, the original data, or nil on error<br>
--  - `errCode`: nil, or one of the following values on error:<br>
--      - `bz2.DECOMPRESS_NOMEM`: out of memory, TPT will probably crash soon<br>
--      - `bz2.DECOMPRESS_LIMIT`: the length of data would exceed maxSize<br>
--      - `bz2.DECOMPRESS_TYPE`: compressedData is not bzip2-compressed data<br>
--      - `bz2.DECOMPRESS_BAD`: compressedData is otherwise corrupt<br>
--      - `bz2.DECOMPRESS_EOF`: compressedData contains data beyond the end of the bzip2 stream<br>
--  - `errStr`: nil, or a human-friendly string that explains the error<br>
---@param sourceData string
---@param maxSize integer?
---@return string | nil, bz2DecompressErr, string | nil
function bz2.decompress(sourceData, maxSize) end


bz2.COMPRESS_NOMEM = 1
bz2.COMPRESS_LIMIT = 2

bz2.DECOMPRESS_NOMEM = 1
bz2.DECOMPRESS_LIMIT = 2
bz2.DECOMPRESS_TYPE = 3
bz2.DECOMPRESS_BAD = 4
bz2.DECOMPRESS_EOF = 5
