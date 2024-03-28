---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- TODO: Change enum to alias, move bz2 declaration below all @alias annotations

-- The `bz2` API provides access to the bzip2 library TPT bundles. It can be used for compressing and decompressing blocks of data, such as TPT saves.<br>
-- Only one-shot functionality is exposed because streaming functionality is only useful for tasks that are beyond the scope of this API.<br>
-- Unless stated otherwise, all functions raise errors if supplied with parameters that disagree with their descriptions. 
bz2 = {}

---@enum bz2Result
bz2 = {
    --Compression OK
    compressOk = 0,

    --Compression failed, ran out of memory
    compressNomem = 1,

    --Compression failed, maxSize limit exceeded
    compressLimit = 2,

    --Decompression OK
    decompressOk = 0,

    --Decompression failed, ran out of memory
    decompressNomem = 4,

    --Decompression failed, maxSize limit exceeded
    decompressLimit = 2,

    --Decompression failed, sourceData does not have bzip2 header and is likely not bzip2 data
    decompressType = 3,

    --Decompression failed, sourceData is not valid bzip2 data
    decompressBad = 4,
    
    decompressEof = 5,
}

--```
--bz2.compress(sourceData, maxSize)
--```
-- Accepts source data and returns a string containing the compressed data. maxSize controls the maximum amount of memory to use while compressing the sourceData, and can be 0 to allow unlimited memory.<br>
-- On success, returns 1 argument - the compressed data<br>
-- On failure, returns 3 arguments - nil, error code, error string. Error code will be one of the bz2. constants
---@param sourceData string
---@param maxSize integer?
---@return string | nil, bz2Result, string
function bz2.compress(sourceData, maxSize) end

--```
--bz2.decompress(sourceData, maxSize)
--```
-- Accepts source data and returns a string containing the decompressed data. maxSize controls the maximum amount of memory to use while decompressing the sourceData, and can be 0 to allow unlimited memory.
-- On success, returns 1 argument - the decompressed data
-- On failure, returns 3 arguments - nil, error code, error string. Error code will be one of the bz2. constants
---@param sourceData string
---@param maxSize integer?
---@return string | nil, bz2Result, string
function bz2.decompress(sourceData, maxSize) end


