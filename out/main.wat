(module
 (type $FUNCSIG$ii (func (param i32) (result i32)))
 (type $FUNCSIG$iii (func (param i32 i32) (result i32)))
 (type $FUNCSIG$vi (func (param i32)))
 (type $FUNCSIG$viii (func (param i32 i32 i32)))
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$vii (func (param i32 i32)))
 (type $FUNCSIG$i (func (result i32)))
 (type $FUNCSIG$iiii (func (param i32 i32 i32) (result i32)))
 (type $FUNCSIG$iiiii (func (param i32 i32 i32 i32) (result i32)))
 (type $FUNCSIG$jii (func (param i32 i32) (result i64)))
 (type $FUNCSIG$viiiii (func (param i32 i32 i32 i32 i32)))
 (import "env" "debug_log" (func $main/debug (param i32)))
 (import "env" "debug_mem" (func $main/debug_mem (param i32 i32)))
 (import "env" "eth2_blockDataSize" (func $main/eth2_blockDataSize (result i32)))
 (import "env" "eth2_blockDataCopy" (func $main/eth2_blockDataCopy (param i32 i32 i32)))
 (import "env" "eth2_loadPreStateRoot" (func $main/eth2_loadPreStateRoot (param i32)))
 (import "env" "eth2_savePostStateRoot" (func $main/eth2_savePostStateRoot (param i32)))
 (import "watimports" "$ethash_keccak256" (func $keccak/ethash_keccak256 (param i32 i32 i32)))
 (memory $0 1)
 (data (i32.const 10000) " \00\00\00\01\00\00\00\01\00\00\00 \00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f")
 (data (i32.const 10052) "\01\00\00\00\01")
 (data (i32.const 10064) "\02\00\00\00\01\00\00\00\01\00\00\00\02\00\00\000")
 (data (i32.const 10088) "\08\00\00\00\01\00\00\00\01\00\00\00\08\00\00\00n\00u\00l\00l")
 (data (i32.const 10112) "\04\00\00\00\01\00\00\00\01\00\00\00\04\00\00\000\000")
 (data (i32.const 10140) "\01")
 (data (i32.const 10156) "\01")
 (data (i32.const 10168) " \00\00\00\01\00\00\00\00\00\00\00 \00\00\00\0e\8d\00x\84\8f6s^\87\b7nb\90#\c1\f5(v\a4B\t\c0x\ddB\83-\08\d0\0f\b1")
 (data (i32.const 10216) "I\00\00\00\01\00\00\00\00\00\00\00I\00\00\00\f8G\80\83\ff\ff\ff\a0V\e8\1f\17\1b\ccU\a6\ff\83E\e6\92\c0\f8n[H\e0\1b\99l\ad\c0\01b/\b5\e3c\b4!\a0\c5\d2F\01\86\f7#<\92~}\b2\dc\c7\03\c0\e5\00\b6S\ca\82\';{\fa\d8\04]\85\a4p")
 (table $0 2 funcref)
 (elem (i32.const 0) $null $rlp/concatUint8Arrays~anonymous|0)
 (global $~lib/rt/stub/startOffset (mut i32) (i32.const 0))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (global $main/Trie (mut i32) (i32.const 0))
 (global $~lib/argc (mut i32) (i32.const 0))
 (export "memory" (memory $0))
 (export "debug" (func $main/debug))
 (export "debug_mem" (func $main/debug_mem))
 (export "eth2_blockDataSize" (func $main/eth2_blockDataSize))
 (export "eth2_blockDataCopy" (func $main/eth2_blockDataCopy))
 (export "eth2_loadPreStateRoot" (func $main/eth2_loadPreStateRoot))
 (export "eth2_savePostStateRoot" (func $main/eth2_savePostStateRoot))
 (export "main" (func $main/main))
 (start $start)
 (func $~lib/rt/stub/__alloc (; 7 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  i32.const 1073741808
  i32.gt_u
  if
   unreachable
  end
  global.get $~lib/rt/stub/offset
  i32.const 16
  i32.add
  local.tee $3
  local.get $0
  i32.const 1
  local.get $0
  i32.const 1
  i32.gt_u
  select
  i32.add
  i32.const 15
  i32.add
  i32.const -16
  i32.and
  local.tee $2
  memory.size
  local.tee $4
  i32.const 16
  i32.shl
  i32.gt_u
  if
   local.get $4
   local.get $2
   local.get $3
   i32.sub
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $5
   local.get $4
   local.get $5
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $5
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $2
  global.set $~lib/rt/stub/offset
  local.get $3
  i32.const 16
  i32.sub
  local.tee $2
  local.get $1
  i32.store offset=8
  local.get $2
  local.get $0
  i32.store offset=12
  local.get $3
 )
 (func $~lib/memory/memory.fill (; 8 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i64)
  block $~lib/util/memory/memset|inlined.0
   local.get $2
   i32.eqz
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   local.get $1
   i32.store8
   local.get $0
   local.get $2
   i32.add
   i32.const 1
   i32.sub
   local.get $1
   i32.store8
   local.get $2
   i32.const 2
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 1
   i32.add
   local.get $1
   i32.store8
   local.get $0
   i32.const 2
   i32.add
   local.get $1
   i32.store8
   local.get $0
   local.get $2
   i32.add
   local.tee $3
   i32.const 2
   i32.sub
   local.get $1
   i32.store8
   local.get $3
   i32.const 3
   i32.sub
   local.get $1
   i32.store8
   local.get $2
   i32.const 6
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 3
   i32.add
   local.get $1
   i32.store8
   local.get $0
   local.get $2
   i32.add
   i32.const 4
   i32.sub
   local.get $1
   i32.store8
   local.get $2
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $2
   i32.const 0
   local.get $0
   i32.sub
   i32.const 3
   i32.and
   local.tee $2
   i32.sub
   local.get $0
   local.get $2
   i32.add
   local.tee $2
   local.get $1
   i32.const 255
   i32.and
   i32.const 16843009
   i32.mul
   local.tee $0
   i32.store
   i32.const -4
   i32.and
   local.tee $3
   local.get $2
   i32.add
   i32.const 4
   i32.sub
   local.get $0
   i32.store
   local.get $3
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $2
   i32.const 4
   i32.add
   local.get $0
   i32.store
   local.get $2
   i32.const 8
   i32.add
   local.get $0
   i32.store
   local.get $2
   local.get $3
   i32.add
   local.tee $1
   i32.const 12
   i32.sub
   local.get $0
   i32.store
   local.get $1
   i32.const 8
   i32.sub
   local.get $0
   i32.store
   local.get $3
   i32.const 24
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $2
   i32.const 12
   i32.add
   local.get $0
   i32.store
   local.get $2
   i32.const 16
   i32.add
   local.get $0
   i32.store
   local.get $2
   i32.const 20
   i32.add
   local.get $0
   i32.store
   local.get $2
   i32.const 24
   i32.add
   local.get $0
   i32.store
   local.get $2
   local.get $3
   i32.add
   local.tee $1
   i32.const 28
   i32.sub
   local.get $0
   i32.store
   local.get $1
   i32.const 24
   i32.sub
   local.get $0
   i32.store
   local.get $1
   i32.const 20
   i32.sub
   local.get $0
   i32.store
   local.get $1
   i32.const 16
   i32.sub
   local.get $0
   i32.store
   local.get $2
   local.get $2
   i32.const 4
   i32.and
   i32.const 24
   i32.add
   local.tee $2
   i32.add
   local.set $1
   local.get $3
   local.get $2
   i32.sub
   local.set $2
   local.get $0
   i64.extend_i32_u
   local.get $0
   i64.extend_i32_u
   i64.const 32
   i64.shl
   i64.or
   local.set $4
   loop $continue|0
    local.get $2
    i32.const 32
    i32.lt_u
    i32.eqz
    if
     local.get $1
     local.get $4
     i64.store
     local.get $1
     i32.const 8
     i32.add
     local.get $4
     i64.store
     local.get $1
     i32.const 16
     i32.add
     local.get $4
     i64.store
     local.get $1
     i32.const 24
     i32.add
     local.get $4
     i64.store
     local.get $2
     i32.const 32
     i32.sub
     local.set $2
     local.get $1
     i32.const 32
     i32.add
     local.set $1
     br $continue|0
    end
   end
  end
 )
 (func $~lib/arraybuffer/ArrayBuffer#constructor (; 9 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 1073741808
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/rt/stub/__alloc
  local.tee $1
  i32.const 0
  local.get $0
  call $~lib/memory/memory.fill
  local.get $1
 )
 (func $~lib/map/Map<usize,main/Node>#clear (; 10 ;) (type $FUNCSIG$vi) (param $0 i32)
  (local $1 i32)
  i32.const 16
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $1
  local.get $0
  i32.load
  drop
  local.get $0
  local.get $1
  i32.store
  local.get $0
  i32.const 3
  i32.store offset=4
  i32.const 48
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $1
  local.get $0
  i32.load offset=8
  drop
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $0
  i32.const 4
  i32.store offset=12
  local.get $0
  i32.const 0
  i32.store offset=16
  local.get $0
  i32.const 0
  i32.store offset=20
 )
 (func $~lib/map/Map<usize,main/Node>#constructor (; 11 ;) (type $FUNCSIG$i) (result i32)
  (local $0 i32)
  i32.const 24
  i32.const 8
  call $~lib/rt/stub/__alloc
  local.tee $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.const 0
  i32.store offset=8
  local.get $0
  i32.const 0
  i32.store offset=12
  local.get $0
  i32.const 0
  i32.store offset=16
  local.get $0
  i32.const 0
  i32.store offset=20
  local.get $0
  call $~lib/map/Map<usize,main/Node>#clear
  local.get $0
 )
 (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (; 12 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 16
  i32.sub
  i32.load offset=12
 )
 (func $~lib/typedarray/Uint64Array.wrap (; 13 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  block $folding-inner0
   i32.const 0
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.ge_u
   br_if $folding-inner0
   i32.const 32
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.gt_s
   br_if $folding-inner0
   i32.const 12
   i32.const 9
   call $~lib/rt/stub/__alloc
   local.tee $1
   local.get $1
   i32.load
   drop
   local.get $0
   i32.store
   local.get $1
   i32.const 32
   i32.store offset=8
   local.get $1
   local.get $0
   i32.store offset=4
   local.get $1
   return
  end
  unreachable
 )
 (func $~lib/typedarray/Uint8Array.wrap (; 14 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  block $folding-inner0
   i32.const 0
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.ge_u
   br_if $folding-inner0
   local.get $1
   i32.const 0
   i32.lt_s
   if
    local.get $1
    i32.const -1
    i32.ne
    br_if $folding-inner0
    local.get $0
    call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    i32.const -2147483648
    i32.and
    br_if $folding-inner0
    local.get $0
    call $~lib/arraybuffer/ArrayBuffer#get:byteLength
    local.set $1
   end
   local.get $1
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.gt_s
   br_if $folding-inner0
   i32.const 12
   i32.const 7
   call $~lib/rt/stub/__alloc
   local.tee $2
   local.get $2
   i32.load
   drop
   local.get $0
   i32.store
   local.get $2
   local.get $1
   i32.store offset=8
   local.get $2
   local.get $0
   i32.store offset=4
   local.get $2
   return
  end
  unreachable
 )
 (func $~lib/typedarray/Uint8Array#__get (; 15 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.add
  i32.load8_u
 )
 (func $rlp/Decoded#constructor (; 16 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  i32.const 8
  i32.const 12
  call $~lib/rt/stub/__alloc
  local.tee $2
  i32.const 0
  i32.store
  local.get $2
  i32.const 0
  i32.store offset=4
  local.get $2
  i32.load
  drop
  local.get $2
  local.get $0
  i32.store
  local.get $2
  i32.load offset=4
  drop
  local.get $2
  local.get $1
  i32.store offset=4
  local.get $2
 )
 (func $~lib/arraybuffer/ArrayBufferView#constructor (; 17 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 1073741808
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   unreachable
  end
  local.get $1
  local.get $2
  i32.shl
  local.tee $2
  i32.const 0
  call $~lib/rt/stub/__alloc
  local.tee $1
  i32.const 0
  local.get $2
  call $~lib/memory/memory.fill
  local.get $0
  i32.eqz
  if
   i32.const 12
   i32.const 2
   call $~lib/rt/stub/__alloc
   local.set $0
  end
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.const 0
  i32.store offset=8
  local.get $0
  i32.load
  drop
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $2
  i32.store offset=8
  local.get $0
 )
 (func $~lib/typedarray/Uint8Array#constructor (; 18 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  i32.const 12
  i32.const 7
  call $~lib/rt/stub/__alloc
  local.get $0
  i32.const 0
  call $~lib/arraybuffer/ArrayBufferView#constructor
 )
 (func $rlp/RLPData#constructor (; 19 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  if
   i32.const 8
   i32.const 10
   call $~lib/rt/stub/__alloc
   local.tee $2
   i32.const 0
   i32.store
   local.get $2
   i32.const 0
   i32.store offset=4
  else   
   i32.const 8
   i32.const 10
   call $~lib/rt/stub/__alloc
   local.tee $2
   i32.const 0
   i32.store
   local.get $2
   i32.const 0
   i32.store offset=4
   i32.const 0
   call $~lib/typedarray/Uint8Array#constructor
   local.set $0
  end
  local.get $2
  i32.load
  drop
  local.get $2
  local.get $0
  i32.store
  local.get $1
  if
   local.get $2
   i32.load offset=4
   drop
   local.get $2
   local.get $1
   i32.store offset=4
  else   
   i32.const 16
   i32.const 11
   call $~lib/rt/stub/__alloc
   i32.const 0
   i32.const 2
   call $~lib/arraybuffer/ArrayBufferView#constructor
   local.tee $0
   i32.const 0
   i32.store offset=12
   local.get $0
   i32.const 0
   i32.store offset=12
   local.get $2
   i32.load offset=4
   drop
   local.get $2
   local.get $0
   i32.store offset=4
  end
  local.get $2
 )
 (func $~lib/typedarray/Uint8Array#subarray (; 20 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  local.tee $4
  i32.load offset=8
  local.set $3
  local.get $1
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $1
   local.get $3
   i32.add
   local.tee $0
   i32.const 0
   local.get $0
   i32.const 0
   i32.gt_s
   select
  else   
   local.get $1
   local.get $3
   local.get $1
   local.get $3
   i32.lt_s
   select
  end
  local.set $0
  local.get $2
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $2
   local.get $3
   i32.add
   local.tee $1
   i32.const 0
   local.get $1
   i32.const 0
   i32.gt_s
   select
  else   
   local.get $2
   local.get $3
   local.get $2
   local.get $3
   i32.lt_s
   select
  end
  local.set $2
  i32.const 12
  i32.const 7
  call $~lib/rt/stub/__alloc
  local.set $1
  local.get $4
  i32.load
  local.tee $3
  local.get $1
  i32.load
  i32.ne
  drop
  local.get $1
  local.get $3
  i32.store
  local.get $1
  local.get $4
  i32.load offset=4
  local.get $0
  i32.add
  i32.store offset=4
  local.get $1
  local.get $2
  local.get $0
  local.get $2
  local.get $0
  i32.gt_s
  select
  local.get $0
  i32.sub
  i32.store offset=8
  local.get $1
 )
 (func $~lib/string/String#get:length (; 21 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 16
  i32.sub
  i32.load offset=12
  i32.const 1
  i32.shr_u
 )
 (func $~lib/string/String#charAt (; 22 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 10016
  call $~lib/string/String#get:length
  i32.ge_u
  if
   i32.const 10064
   return
  end
  i32.const 2
  i32.const 1
  call $~lib/rt/stub/__alloc
  local.tee $1
  local.get $0
  i32.const 1
  i32.shl
  i32.const 10016
  i32.add
  i32.load16_u
  i32.store16
  local.get $1
 )
 (func $~lib/memory/memory.copy (; 23 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $~lib/util/memory/memmove|inlined.0
   local.get $2
   local.set $3
   local.get $0
   local.get $1
   i32.eq
   br_if $~lib/util/memory/memmove|inlined.0
   local.get $0
   local.get $1
   i32.lt_u
   if
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $continue|0
      local.get $0
      i32.const 7
      i32.and
      if
       local.get $3
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $3
       i32.const 1
       i32.sub
       local.set $3
       local.get $0
       local.tee $2
       i32.const 1
       i32.add
       local.set $0
       local.get $1
       local.tee $4
       i32.const 1
       i32.add
       local.set $1
       local.get $2
       local.get $4
       i32.load8_u
       i32.store8
       br $continue|0
      end
     end
     loop $continue|1
      local.get $3
      i32.const 8
      i32.lt_u
      i32.eqz
      if
       local.get $0
       local.get $1
       i64.load
       i64.store
       local.get $3
       i32.const 8
       i32.sub
       local.set $3
       local.get $0
       i32.const 8
       i32.add
       local.set $0
       local.get $1
       i32.const 8
       i32.add
       local.set $1
       br $continue|1
      end
     end
    end
    loop $continue|2
     local.get $3
     if
      local.get $0
      local.tee $2
      i32.const 1
      i32.add
      local.set $0
      local.get $1
      local.tee $4
      i32.const 1
      i32.add
      local.set $1
      local.get $2
      local.get $4
      i32.load8_u
      i32.store8
      local.get $3
      i32.const 1
      i32.sub
      local.set $3
      br $continue|2
     end
    end
   else    
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $continue|3
      local.get $0
      local.get $3
      i32.add
      i32.const 7
      i32.and
      if
       local.get $3
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $0
       local.get $3
       i32.const 1
       i32.sub
       local.tee $3
       i32.add
       local.get $1
       local.get $3
       i32.add
       i32.load8_u
       i32.store8
       br $continue|3
      end
     end
     loop $continue|4
      local.get $3
      i32.const 8
      i32.lt_u
      i32.eqz
      if
       local.get $0
       local.get $3
       i32.const 8
       i32.sub
       local.tee $3
       i32.add
       local.get $1
       local.get $3
       i32.add
       i64.load
       i64.store
       br $continue|4
      end
     end
    end
    loop $continue|5
     local.get $3
     if
      local.get $0
      local.get $3
      i32.const 1
      i32.sub
      local.tee $3
      i32.add
      local.get $1
      local.get $3
      i32.add
      i32.load8_u
      i32.store8
      br $continue|5
     end
    end
   end
  end
 )
 (func $~lib/rt/stub/__realloc (; 24 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $1
  local.get $0
  i32.const 16
  i32.sub
  local.tee $2
  i32.load offset=12
  local.tee $3
  i32.gt_u
  if
   local.get $1
   local.get $2
   i32.load offset=8
   call $~lib/rt/stub/__alloc
   local.tee $1
   local.get $0
   local.get $3
   call $~lib/memory/memory.copy
   local.get $1
   local.set $0
  else   
   local.get $2
   local.get $1
   i32.store offset=12
  end
  local.get $0
 )
 (func $~lib/array/ensureSize (; 25 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   local.get $1
   i32.const 1073741808
   local.get $2
   i32.shr_u
   i32.gt_u
   if
    unreachable
   end
   local.get $0
   i32.load
   local.tee $4
   local.get $1
   local.get $2
   i32.shl
   local.tee $2
   call $~lib/rt/stub/__realloc
   local.tee $1
   local.get $3
   i32.add
   i32.const 0
   local.get $2
   local.get $3
   i32.sub
   call $~lib/memory/memory.fill
   local.get $1
   local.get $4
   i32.ne
   if
    local.get $0
    local.get $1
    i32.store
    local.get $0
    local.get $1
    i32.store offset=4
   end
   local.get $0
   local.get $2
   i32.store offset=8
  end
 )
 (func $~lib/array/Array<~lib/string/String>#push (; 26 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 1
  i32.add
  local.tee $3
  i32.const 2
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store
  local.get $0
  local.get $3
  i32.store offset=12
 )
 (func $~lib/array/Array<~lib/string/String>#reverse (; 27 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=12
  local.tee $1
  if
   local.get $0
   i32.load offset=4
   local.set $2
   local.get $0
   i32.load offset=4
   local.get $1
   i32.const 1
   i32.sub
   i32.const 2
   i32.shl
   i32.add
   local.set $1
   loop $continue|0
    local.get $2
    local.get $1
    i32.lt_u
    if
     local.get $2
     i32.load
     local.set $3
     local.get $2
     local.get $1
     i32.load
     i32.store
     local.get $1
     local.get $3
     i32.store
     local.get $2
     i32.const 4
     i32.add
     local.set $2
     local.get $1
     i32.const 4
     i32.sub
     local.set $1
     br $continue|0
    end
   end
  end
  local.get $0
 )
 (func $~lib/array/Array<~lib/string/String>#join_str (; 28 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  i32.load offset=12
  i32.const 1
  i32.sub
  local.tee $4
  i32.const 0
  i32.lt_s
  if
   i32.const 10064
   return
  end
  local.get $0
  i32.load offset=4
  local.set $5
  local.get $4
  i32.eqz
  if
   local.get $5
   i32.load
   return
  end
  i32.const 10064
  call $~lib/string/String#get:length
  local.set $6
  i32.const 0
  local.set $0
  local.get $4
  i32.const 1
  i32.add
  local.set $3
  loop $loop|0
   local.get $1
   local.get $3
   i32.lt_s
   if
    local.get $1
    i32.const 2
    i32.shl
    local.get $5
    i32.add
    i32.load
    local.set $0
    local.get $0
    if
     local.get $0
     call $~lib/string/String#get:length
     local.get $2
     i32.add
     local.set $2
    end
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $loop|0
   end
  end
  i32.const 0
  local.set $1
  local.get $4
  local.get $6
  i32.mul
  local.get $2
  i32.add
  i32.const 1
  i32.shl
  i32.const 1
  call $~lib/rt/stub/__alloc
  local.set $2
  i32.const 0
  local.set $3
  loop $loop|1
   local.get $3
   local.get $4
   i32.lt_s
   if
    local.get $3
    i32.const 2
    i32.shl
    local.get $5
    i32.add
    i32.load
    local.set $0
    local.get $0
    if
     local.get $1
     i32.const 1
     i32.shl
     local.get $2
     i32.add
     local.get $0
     local.get $0
     call $~lib/string/String#get:length
     local.tee $7
     i32.const 1
     i32.shl
     call $~lib/memory/memory.copy
     local.get $1
     local.get $7
     i32.add
     local.set $1
    end
    local.get $6
    if
     local.get $1
     i32.const 1
     i32.shl
     local.get $2
     i32.add
     i32.const 10064
     local.get $6
     i32.const 1
     i32.shl
     call $~lib/memory/memory.copy
     local.get $1
     local.get $6
     i32.add
     local.set $1
    end
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $loop|1
   end
  end
  local.get $4
  i32.const 2
  i32.shl
  local.get $5
  i32.add
  i32.load
  local.set $0
  local.get $0
  if
   local.get $1
   i32.const 1
   i32.shl
   local.get $2
   i32.add
   local.get $0
   local.get $0
   call $~lib/string/String#get:length
   i32.const 1
   i32.shl
   call $~lib/memory/memory.copy
  end
  local.get $2
 )
 (func $~lib/string/String#concat (; 29 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 10080
  call $~lib/string/String#get:length
  i32.const 1
  i32.shl
  local.set $2
  local.get $2
  local.get $0
  i32.const 10104
  local.get $0
  select
  local.tee $0
  call $~lib/string/String#get:length
  i32.const 1
  i32.shl
  local.tee $3
  i32.add
  local.tee $1
  i32.eqz
  if
   i32.const 10064
   return
  end
  local.get $1
  i32.const 1
  call $~lib/rt/stub/__alloc
  local.tee $1
  i32.const 10080
  local.get $2
  call $~lib/memory/memory.copy
  local.get $1
  local.get $2
  i32.add
  local.get $0
  local.get $3
  call $~lib/memory/memory.copy
  local.get $1
 )
 (func $rlp/intToHex (; 30 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  i32.const 16
  i32.const 13
  call $~lib/rt/stub/__alloc
  i32.const 0
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.tee $1
  i32.const 0
  i32.store offset=12
  local.get $1
  i32.const 0
  i32.store offset=12
  loop $continue|0
   local.get $0
   i32.const 15
   i32.and
   local.set $2
   local.get $0
   i32.const 16
   i32.div_u
   local.set $0
   local.get $1
   local.get $2
   call $~lib/string/String#charAt
   call $~lib/array/Array<~lib/string/String>#push
   local.get $0
   br_if $continue|0
  end
  local.get $1
  call $~lib/array/Array<~lib/string/String>#reverse
  call $~lib/array/Array<~lib/string/String>#join_str
  local.tee $0
  call $~lib/string/String#get:length
  i32.const 2
  i32.rem_s
  if (result i32)
   local.get $0
   call $~lib/string/String#concat
  else   
   local.get $0
  end
 )
 (func $~lib/string/String#charCodeAt (; 31 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  call $~lib/string/String#get:length
  i32.ge_u
  if
   i32.const -1
   return
  end
  local.get $1
  i32.const 1
  i32.shl
  local.get $0
  i32.add
  i32.load16_u
 )
 (func $~lib/typedarray/Uint8Array#__set (; 32 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.add
  local.get $2
  i32.store8
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:byteOffset (; 33 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.load offset=4
  local.get $0
  i32.load
  i32.sub
 )
 (func $~lib/string/String.UTF8.decodeUnsafe (; 34 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  local.get $1
  i32.add
  local.tee $4
  local.get $0
  i32.lt_u
  if
   unreachable
  end
  local.get $1
  i32.const 1
  i32.shl
  i32.const 1
  call $~lib/rt/stub/__alloc
  local.tee $5
  local.set $2
  loop $continue|0
   block $break|0
    local.get $0
    local.get $4
    i32.ge_u
    br_if $break|0
    local.get $0
    local.tee $1
    i32.const 1
    i32.add
    local.set $0
    local.get $1
    i32.load8_u
    local.tee $3
    i32.const 128
    i32.lt_u
    if
     local.get $2
     local.get $3
     i32.store16
     local.get $2
     i32.const 2
     i32.add
     local.set $2
    else     
     local.get $3
     i32.const 224
     i32.lt_u
     i32.const 0
     local.get $3
     i32.const 191
     i32.gt_u
     select
     if
      local.get $4
      local.get $0
      i32.sub
      i32.const 1
      i32.lt_u
      br_if $break|0
      local.get $0
      local.tee $1
      i32.const 1
      i32.add
      local.set $0
      local.get $2
      local.get $1
      i32.load8_u
      i32.const 63
      i32.and
      local.get $3
      i32.const 31
      i32.and
      i32.const 6
      i32.shl
      i32.or
      i32.store16
      local.get $2
      i32.const 2
      i32.add
      local.set $2
     else      
      local.get $3
      i32.const 365
      i32.lt_u
      i32.const 0
      local.get $3
      i32.const 239
      i32.gt_u
      select
      if (result i32)
       local.get $4
       local.get $0
       i32.sub
       i32.const 3
       i32.lt_u
       br_if $break|0
       local.get $2
       local.get $0
       i32.load8_u offset=2
       i32.const 63
       i32.and
       local.get $3
       i32.const 7
       i32.and
       i32.const 18
       i32.shl
       local.get $0
       i32.load8_u
       i32.const 63
       i32.and
       i32.const 12
       i32.shl
       i32.or
       local.get $0
       i32.load8_u offset=1
       i32.const 63
       i32.and
       i32.const 6
       i32.shl
       i32.or
       i32.or
       i32.const 65536
       i32.sub
       local.tee $1
       i32.const 10
       i32.shr_u
       i32.const 55296
       i32.add
       i32.store16
       local.get $2
       local.get $1
       i32.const 1023
       i32.and
       i32.const 56320
       i32.add
       i32.store16 offset=2
       local.get $2
       i32.const 4
       i32.add
       local.set $2
       local.get $0
       i32.const 3
       i32.add
      else       
       local.get $4
       local.get $0
       i32.sub
       i32.const 2
       i32.lt_u
       br_if $break|0
       local.get $2
       local.get $0
       i32.load8_u offset=1
       i32.const 63
       i32.and
       local.get $3
       i32.const 15
       i32.and
       i32.const 12
       i32.shl
       local.get $0
       i32.load8_u
       i32.const 63
       i32.and
       i32.const 6
       i32.shl
       i32.or
       i32.or
       i32.store16
       local.get $2
       i32.const 2
       i32.add
       local.set $2
       local.get $0
       i32.const 2
       i32.add
      end
      local.set $0
     end
    end
    br $continue|0
   end
  end
  local.get $5
  local.get $2
  local.get $5
  i32.sub
  call $~lib/rt/stub/__realloc
 )
 (func $rlp/bytesToHex (; 35 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.load offset=8
  i32.const 1
  i32.shl
  call $~lib/typedarray/Uint8Array#constructor
  local.set $1
  loop $loop|0
   local.get $2
   local.get $0
   i32.load offset=8
   i32.lt_s
   if
    local.get $1
    local.get $2
    i32.const 1
    i32.shl
    local.tee $3
    local.get $0
    local.get $2
    call $~lib/typedarray/Uint8Array#__get
    call $rlp/intToHex
    local.tee $4
    i32.const 0
    call $~lib/string/String#charCodeAt
    call $~lib/typedarray/Uint8Array#__set
    local.get $1
    local.get $3
    i32.const 1
    i32.add
    local.get $4
    i32.const 1
    call $~lib/string/String#charCodeAt
    call $~lib/typedarray/Uint8Array#__set
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $loop|0
   end
  end
  local.get $1
  i32.load
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $1
  i32.load offset=8
  call $~lib/string/String.UTF8.decodeUnsafe
 )
 (func $~lib/string/String#slice (; 36 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 0
  local.get $0
  call $~lib/string/String#get:length
  local.tee $1
  i32.const 0
  local.get $1
  i32.lt_s
  select
  local.set $2
  i32.const 2
  local.get $1
  i32.const 2
  local.get $1
  i32.lt_s
  select
  local.get $2
  i32.sub
  local.tee $1
  i32.const 0
  i32.le_s
  if
   i32.const 10064
   return
  end
  local.get $1
  i32.const 1
  i32.shl
  local.tee $1
  i32.const 1
  call $~lib/rt/stub/__alloc
  local.tee $3
  local.get $2
  i32.const 1
  i32.shl
  local.get $0
  i32.add
  local.get $1
  call $~lib/memory/memory.copy
  local.get $3
 )
 (func $~lib/util/string/compareImpl (; 37 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 10128
  local.set $2
  loop $continue|0
   local.get $1
   if (result i32)
    local.get $0
    i32.load16_u
    local.get $2
    i32.load16_u
    i32.sub
    local.tee $3
    i32.eqz
   else    
    i32.const 0
   end
   if
    local.get $1
    i32.const 1
    i32.sub
    local.set $1
    local.get $0
    i32.const 2
    i32.add
    local.set $0
    local.get $2
    i32.const 2
    i32.add
    local.set $2
    br $continue|0
   end
  end
  local.get $3
 )
 (func $~lib/string/String.__eq (; 38 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 10128
  i32.eq
  if
   i32.const 1
   return
  end
  block $folding-inner0
   i32.const 0
   i32.const 1
   local.get $0
   select
   br_if $folding-inner0
   local.get $0
   call $~lib/string/String#get:length
   local.tee $1
   i32.const 10128
   call $~lib/string/String#get:length
   i32.ne
   br_if $folding-inner0
   local.get $0
   local.get $1
   call $~lib/util/string/compareImpl
   i32.eqz
   return
  end
  i32.const 0
 )
 (func $~lib/util/string/isSpace (; 39 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 255
  i32.le_s
  if
   block $break|0
    block $case6|0
     local.get $0
     i32.const 10
     i32.eq
     local.get $0
     i32.const 11
     i32.eq
     i32.or
     local.get $0
     i32.const 9
     i32.eq
     i32.or
     br_if $case6|0
     local.get $0
     i32.const 12
     i32.eq
     local.get $0
     i32.const 13
     i32.eq
     i32.or
     local.get $0
     i32.const 32
     i32.eq
     local.get $0
     i32.const 160
     i32.eq
     i32.or
     i32.or
     br_if $case6|0
     br $break|0
    end
    i32.const 1
    return
   end
   i32.const 0
   return
  end
  local.get $0
  i32.const 8202
  i32.le_s
  i32.const 0
  local.get $0
  i32.const 8192
  i32.ge_s
  select
  if
   i32.const 1
   return
  end
  block $break|1
   block $case6|1
    local.get $0
    i32.const 8232
    i32.eq
    local.get $0
    i32.const 8233
    i32.eq
    i32.or
    local.get $0
    i32.const 5760
    i32.eq
    i32.or
    br_if $case6|1
    local.get $0
    i32.const 8239
    i32.eq
    local.get $0
    i32.const 8287
    i32.eq
    i32.or
    local.get $0
    i32.const 12288
    i32.eq
    local.get $0
    i32.const 65279
    i32.eq
    i32.or
    i32.or
    br_if $case6|1
    br $break|1
   end
   i32.const 1
   return
  end
  i32.const 0
 )
 (func $~lib/util/string/strtol<i32> (; 40 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $folding-inner0
   local.get $0
   call $~lib/string/String#get:length
   local.tee $2
   i32.eqz
   br_if $folding-inner0
   local.get $0
   local.tee $1
   i32.load16_u
   local.set $0
   i32.const 1
   local.set $3
   loop $continue|0
    local.get $0
    call $~lib/util/string/isSpace
    if
     local.get $1
     i32.const 2
     i32.add
     local.tee $1
     i32.load16_u
     local.set $0
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
     br $continue|0
    end
   end
   local.get $0
   i32.const 45
   i32.eq
   if
    local.get $2
    i32.const 1
    i32.sub
    local.tee $2
    i32.eqz
    br_if $folding-inner0
    i32.const -1
    local.set $3
    local.get $1
    i32.const 2
    i32.add
    local.tee $1
    i32.load16_u
    drop
   else    
    local.get $0
    i32.const 43
    i32.eq
    if
     local.get $2
     i32.const 1
     i32.sub
     local.tee $2
     i32.eqz
     br_if $folding-inner0
     local.get $1
     i32.const 2
     i32.add
     local.tee $1
     i32.load16_u
     drop
    end
   end
   loop $continue|2
    block $break|2
     local.get $2
     local.tee $0
     i32.const 1
     i32.sub
     local.set $2
     local.get $0
     i32.eqz
     br_if $break|2
     local.get $1
     i32.load16_u
     local.tee $0
     i32.const 48
     i32.ge_s
     if (result i32)
      local.get $0
      i32.const 57
      i32.le_s
     else      
      i32.const 0
     end
     if (result i32)
      local.get $0
      i32.const 48
      i32.sub
     else      
      local.get $0
      i32.const 90
      i32.le_s
      i32.const 0
      local.get $0
      i32.const 65
      i32.ge_s
      select
      if (result i32)
       local.get $0
       i32.const 55
       i32.sub
      else       
       local.get $0
       i32.const 122
       i32.le_s
       i32.const 0
       local.get $0
       i32.const 97
       i32.ge_s
       select
       i32.eqz
       br_if $break|2
       local.get $0
       i32.const 87
       i32.sub
      end
     end
     local.tee $0
     i32.const 16
     i32.ge_s
     br_if $break|2
     local.get $4
     i32.const 4
     i32.shl
     local.get $0
     i32.add
     local.set $4
     local.get $1
     i32.const 2
     i32.add
     local.set $1
     br $continue|2
    end
   end
   local.get $3
   local.get $4
   i32.mul
   return
  end
  i32.const 0
 )
 (func $rlp/safeParseInt (; 41 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  call $~lib/string/String#slice
  call $~lib/string/String.__eq
  if
   unreachable
  end
  local.get $0
  call $~lib/util/string/strtol<i32>
 )
 (func $~lib/rt/__allocArray (; 42 ;) (type $FUNCSIG$iiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  (local $4 i32)
  i32.const 16
  local.get $2
  call $~lib/rt/stub/__alloc
  local.tee $2
  local.get $0
  local.get $1
  i32.shl
  local.tee $1
  i32.const 0
  call $~lib/rt/stub/__alloc
  local.tee $4
  i32.store
  local.get $2
  local.get $4
  i32.store offset=4
  local.get $2
  local.get $1
  i32.store offset=8
  local.get $2
  local.get $0
  i32.store offset=12
  local.get $3
  if
   local.get $4
   local.get $3
   local.get $1
   call $~lib/memory/memory.copy
  end
  local.get $2
 )
 (func $rlp/_decode (; 43 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=8
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/typedarray/Uint8Array#__get
  local.tee $1
  i32.const 127
  i32.le_u
  if (result i32)
   local.get $0
   i32.const 0
   i32.const 1
   call $~lib/typedarray/Uint8Array#subarray
   i32.const 0
   call $rlp/RLPData#constructor
   local.get $0
   i32.const 1
   i32.const 2147483647
   call $~lib/typedarray/Uint8Array#subarray
   call $rlp/Decoded#constructor
  else   
   local.get $1
   i32.const 183
   i32.le_u
   if (result i32)
    local.get $1
    i32.const 127
    i32.sub
    i32.const 255
    i32.and
    local.set $2
    local.get $1
    i32.const 128
    i32.eq
    if
     i32.const 0
     call $~lib/typedarray/Uint8Array#constructor
     i32.const 0
     call $rlp/RLPData#constructor
     local.get $0
     local.get $2
     i32.const 2147483647
     call $~lib/typedarray/Uint8Array#subarray
     call $rlp/Decoded#constructor
     return
    end
    local.get $0
    i32.const 1
    local.get $2
    call $~lib/typedarray/Uint8Array#subarray
    local.set $1
    local.get $2
    i32.const 2
    i32.eq
    if (result i32)
     local.get $1
     i32.const 0
     call $~lib/typedarray/Uint8Array#__get
     i32.const 128
     i32.lt_u
    else     
     i32.const 0
    end
    if
     unreachable
    end
    local.get $1
    i32.const 0
    call $rlp/RLPData#constructor
    local.get $0
    local.get $2
    i32.const 2147483647
    call $~lib/typedarray/Uint8Array#subarray
    call $rlp/Decoded#constructor
   else    
    local.get $1
    i32.const 191
    i32.le_u
    if (result i32)
     local.get $0
     i32.const 1
     local.get $1
     i32.const 182
     i32.sub
     local.tee $3
     i32.const 255
     i32.and
     local.tee $2
     call $~lib/typedarray/Uint8Array#subarray
     call $rlp/bytesToHex
     call $rlp/safeParseInt
     local.set $1
     local.get $0
     local.get $2
     local.get $1
     local.get $2
     i32.add
     call $~lib/typedarray/Uint8Array#subarray
     local.tee $2
     i32.load offset=8
     local.get $1
     i32.lt_u
     if
      unreachable
     end
     local.get $2
     i32.const 0
     call $rlp/RLPData#constructor
     local.get $0
     local.get $3
     i32.const 255
     i32.and
     local.get $1
     i32.add
     i32.const 2147483647
     call $~lib/typedarray/Uint8Array#subarray
     call $rlp/Decoded#constructor
    else     
     local.get $1
     i32.const 247
     i32.le_u
     if (result i32)
      local.get $0
      i32.const 1
      local.get $1
      i32.const 191
      i32.sub
      i32.const 255
      i32.and
      local.tee $3
      call $~lib/typedarray/Uint8Array#subarray
      local.set $1
      i32.const 0
      i32.const 2
      i32.const 11
      i32.const 10152
      call $~lib/rt/__allocArray
      local.set $2
      loop $continue|0
       local.get $1
       i32.load offset=8
       if
        local.get $2
        local.get $1
        call $rlp/_decode
        local.tee $1
        i32.load
        call $~lib/array/Array<~lib/string/String>#push
        local.get $1
        i32.load offset=4
        local.set $1
        br $continue|0
       end
      end
      i32.const 0
      local.get $2
      call $rlp/RLPData#constructor
      local.get $0
      local.get $3
      i32.const 2147483647
      call $~lib/typedarray/Uint8Array#subarray
      call $rlp/Decoded#constructor
     else      
      local.get $0
      i32.const 1
      local.get $1
      i32.const 246
      i32.sub
      local.tee $1
      i32.const 255
      i32.and
      local.tee $2
      call $~lib/typedarray/Uint8Array#subarray
      call $rlp/bytesToHex
      call $rlp/safeParseInt
      local.get $2
      i32.add
      local.tee $2
      local.get $0
      i32.load offset=8
      i32.gt_u
      if
       unreachable
      end
      local.get $0
      local.get $1
      i32.const 255
      i32.and
      local.get $2
      call $~lib/typedarray/Uint8Array#subarray
      local.tee $1
      i32.load offset=8
      i32.eqz
      if
       unreachable
      end
      i32.const 0
      i32.const 2
      i32.const 11
      i32.const 10168
      call $~lib/rt/__allocArray
      local.set $3
      loop $continue|1
       local.get $1
       i32.load offset=8
       if
        local.get $3
        local.get $1
        call $rlp/_decode
        local.tee $1
        i32.load
        call $~lib/array/Array<~lib/string/String>#push
        local.get $1
        i32.load offset=4
        local.set $1
        br $continue|1
       end
      end
      i32.const 0
      local.get $3
      call $rlp/RLPData#constructor
      local.get $0
      local.get $2
      i32.const 2147483647
      call $~lib/typedarray/Uint8Array#subarray
      call $rlp/Decoded#constructor
     end
    end
   end
  end
 )
 (func $rlp/decode (; 44 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  call $rlp/_decode
  local.tee $0
  i32.load offset=4
  i32.load offset=8
  if
   unreachable
  end
  local.get $0
  i32.load
 )
 (func $~lib/array/Array<rlp/RLPData>#__get (; 45 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   unreachable
  end
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
 )
 (func $main/Node#constructor (; 46 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  i32.const 12
  i32.const 3
  call $~lib/rt/stub/__alloc
  local.tee $3
  local.get $0
  i32.store
  local.get $3
  local.get $1
  i32.store offset=4
  local.get $3
  local.get $2
  i32.store offset=8
  local.get $3
 )
 (func $~lib/util/hash/hash32 (; 47 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 255
  i32.and
  i32.const -2128831035
  i32.xor
  i32.const 16777619
  i32.mul
  local.get $0
  i32.const 8
  i32.shr_u
  i32.const 255
  i32.and
  i32.xor
  i32.const 16777619
  i32.mul
  local.get $0
  i32.const 16
  i32.shr_u
  i32.const 255
  i32.and
  i32.xor
  i32.const 16777619
  i32.mul
  local.get $0
  i32.const 24
  i32.shr_u
  i32.xor
  i32.const 16777619
  i32.mul
 )
 (func $~lib/map/Map<usize,main/Node>#find (; 48 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.load
  local.get $0
  i32.load offset=4
  local.get $2
  i32.and
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.set $0
  loop $continue|0
   local.get $0
   if
    local.get $0
    i32.load offset=8
    i32.const 1
    i32.and
    if (result i32)
     i32.const 0
    else     
     local.get $0
     i32.load
     local.get $1
     i32.eq
    end
    if
     local.get $0
     return
    else     
     local.get $0
     i32.load offset=8
     i32.const -2
     i32.and
     local.set $0
     br $continue|0
    end
    unreachable
   end
  end
  i32.const 0
 )
 (func $~lib/map/Map<usize,main/Node>#rehash (; 49 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  local.get $1
  i32.const 1
  i32.add
  local.tee $2
  i32.const 2
  i32.shl
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $4
  local.get $2
  f64.convert_i32_s
  f64.const 2.6666666666666665
  f64.mul
  i32.trunc_f64_s
  local.tee $6
  i32.const 12
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.set $5
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $0
  i32.load offset=16
  i32.const 12
  i32.mul
  i32.add
  local.set $7
  local.get $5
  local.set $2
  loop $continue|0
   local.get $3
   local.get $7
   i32.ne
   if
    local.get $3
    i32.load offset=8
    i32.const 1
    i32.and
    i32.eqz
    if
     local.get $2
     local.get $3
     i32.load
     i32.store
     local.get $2
     local.get $3
     i32.load offset=4
     i32.store offset=4
     local.get $2
     local.get $3
     i32.load
     call $~lib/util/hash/hash32
     local.get $1
     i32.and
     i32.const 2
     i32.shl
     local.get $4
     i32.add
     local.tee $8
     i32.load
     i32.store offset=8
     local.get $8
     local.get $2
     i32.store
     local.get $2
     i32.const 12
     i32.add
     local.set $2
    end
    local.get $3
    i32.const 12
    i32.add
    local.set $3
    br $continue|0
   end
  end
  local.get $0
  i32.load
  drop
  local.get $0
  local.get $4
  i32.store
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  i32.load offset=8
  drop
  local.get $0
  local.get $5
  i32.store offset=8
  local.get $0
  local.get $6
  i32.store offset=12
  local.get $0
  local.get $0
  i32.load offset=20
  i32.store offset=16
 )
 (func $~lib/map/Map<usize,main/Node>#set (; 50 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/hash32
  local.tee $4
  call $~lib/map/Map<usize,main/Node>#find
  local.tee $3
  if
   local.get $3
   i32.load offset=4
   local.get $2
   i32.ne
   if
    local.get $3
    local.get $2
    i32.store offset=4
   end
  else   
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    f64.convert_i32_s
    f64.const 0.75
    f64.mul
    i32.trunc_f64_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else     
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/map/Map<usize,main/Node>#rehash
   end
   local.get $0
   i32.load offset=8
   local.set $3
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $5
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $5
   i32.const 12
   i32.mul
   local.get $3
   i32.add
   local.tee $3
   local.get $1
   i32.store
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $3
   local.get $0
   i32.load
   local.get $0
   i32.load offset=4
   local.get $4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $3
   i32.store
  end
 )
 (func $~lib/typedarray/Uint32Array#__set (; 51 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
 )
 (func $~lib/array/Array<u8>#constructor (; 52 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 16
  i32.const 6
  call $~lib/rt/stub/__alloc
  local.get $0
  i32.const 0
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.tee $1
  i32.const 0
  i32.store offset=12
  local.get $1
  local.get $0
  i32.store offset=12
  local.get $1
 )
 (func $~lib/array/Array<u8>#__set (; 53 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=12
  local.set $3
  local.get $0
  local.get $1
  i32.const 1
  i32.add
  i32.const 0
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.get $1
  i32.add
  local.get $2
  i32.store8
  local.get $1
  local.get $3
  i32.ge_s
  if
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   i32.store offset=12
  end
 )
 (func $~lib/array/Array<usize>#constructor (; 54 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 16
  i32.const 5
  call $~lib/rt/stub/__alloc
  local.get $0
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.tee $1
  i32.const 0
  i32.store offset=12
  local.get $1
  local.get $0
  i32.store offset=12
  local.get $1
 )
 (func $~lib/typedarray/Uint32Array#__get (; 55 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
 )
 (func $~lib/array/Array<usize>#__set (; 56 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=12
  local.set $3
  local.get $0
  local.get $1
  i32.const 1
  i32.add
  i32.const 2
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
  local.get $1
  local.get $3
  i32.ge_s
  if
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   i32.store offset=12
  end
 )
 (func $rlp/RLPBranchNode#constructor (; 57 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 8
  i32.const 4
  call $~lib/rt/stub/__alloc
  local.tee $1
  local.get $0
  i32.store
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
 )
 (func $~lib/array/Array.create<u8> (; 58 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 1073741808
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 0
  i32.const 6
  i32.const 0
  call $~lib/rt/__allocArray
  local.tee $0
  i32.const 0
  i32.store offset=12
  local.get $0
  i32.load offset=4
  i32.const 0
  local.get $0
  i32.load offset=8
  call $~lib/memory/memory.fill
  local.get $0
 )
 (func $~lib/array/Array.create<usize> (; 59 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 268435452
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 5
  i32.const 0
  call $~lib/rt/__allocArray
  local.tee $0
  i32.const 0
  i32.store offset=12
  local.get $0
  i32.load offset=4
  i32.const 0
  local.get $0
  i32.load offset=8
  call $~lib/memory/memory.fill
  local.get $0
 )
 (func $~lib/array/Array<u8>#push (; 60 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 1
  i32.add
  local.tee $3
  i32.const 0
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.get $2
  i32.add
  local.get $1
  i32.store8
  local.get $0
  local.get $3
  i32.store offset=12
 )
 (func $~lib/polyfills/bswap<u16> (; 61 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 8
  i32.shl
  local.get $0
  i32.const 65535
  i32.and
  i32.const 8
  i32.shr_u
  i32.or
 )
 (func $rlp/hashBranchNode (; 62 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 17
  call $~lib/array/Array.create<u8>
  local.set $4
  i32.const 17
  call $~lib/array/Array.create<usize>
  local.set $6
  loop $loop|0
   local.get $1
   i32.const 17
   i32.lt_s
   if
    local.get $0
    local.get $1
    call $~lib/typedarray/Uint32Array#__get
    i32.const 0
    i32.gt_u
    if
     local.get $4
     local.get $1
     call $~lib/array/Array<u8>#push
     local.get $6
     local.get $0
     local.get $1
     call $~lib/typedarray/Uint32Array#__get
     call $~lib/array/Array<~lib/string/String>#push
    end
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $loop|0
   end
  end
  local.get $4
  i32.load offset=12
  local.tee $5
  i32.const 33
  i32.mul
  i32.const 17
  local.get $5
  i32.sub
  i32.add
  local.set $0
  local.get $5
  i32.const 8
  i32.lt_s
  if (result i32)
   local.get $0
   i32.const 2
   i32.add
   local.tee $7
   call $~lib/arraybuffer/ArrayBuffer#constructor
   local.tee $1
   i32.const 248
   i32.store8
   local.get $1
   i32.const 1
   i32.add
   local.get $0
   i32.const 255
   i32.and
   i32.store16
   local.get $1
   i32.const 2
   i32.add
  else   
   local.get $0
   i32.const 3
   i32.add
   local.tee $7
   call $~lib/arraybuffer/ArrayBuffer#constructor
   local.tee $1
   i32.const 249
   i32.store8
   local.get $1
   i32.const 1
   i32.add
   local.get $0
   call $~lib/polyfills/bswap<u16>
   i32.store16
   local.get $1
   i32.const 3
   i32.add
  end
  local.set $0
  loop $continue|1
   local.get $2
   i32.const 17
   i32.lt_u
   if
    local.get $3
    local.get $5
    i32.lt_s
    if
     local.get $2
     local.get $4
     local.get $3
     call $~lib/typedarray/Uint8Array#__get
     local.tee $8
     i32.lt_u
     if
      local.get $0
      i32.const 128
      local.get $8
      local.get $2
      i32.sub
      i32.const 255
      i32.and
      local.tee $2
      call $~lib/memory/memory.fill
      local.get $0
      local.get $2
      i32.add
      local.set $0
      local.get $8
      local.set $2
     end
     local.get $0
     i32.const 160
     i32.store8
     local.get $0
     i32.const 1
     i32.add
     local.tee $0
     local.get $6
     local.get $3
     call $~lib/typedarray/Uint32Array#__get
     i32.const 32
     call $~lib/memory/memory.copy
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     local.get $0
     i32.const 32
     i32.add
     local.set $0
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $continue|1
    else     
     local.get $0
     i32.const 128
     i32.const 17
     local.get $2
     i32.sub
     call $~lib/memory/memory.fill
    end
   end
  end
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $0
  local.get $1
  local.get $7
  call $keccak/ethash_keccak256
  local.get $0
 )
 (func $~lib/typedarray/Uint64Array#__get (; 63 ;) (type $FUNCSIG$jii) (param $0 i32) (param $1 i32) (result i64)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 3
  i32.shr_u
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 3
  i32.shl
  i32.add
  i64.load
 )
 (func $main/u8ArrToNibbleArr (; 64 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.load offset=12
  local.tee $1
  local.set $3
  local.get $1
  i32.const 1
  i32.shl
  call $~lib/array/Array.create<u8>
  local.set $1
  loop $loop|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $1
    local.get $2
    i32.const 1
    i32.shl
    local.tee $4
    local.get $0
    local.get $2
    call $~lib/typedarray/Uint8Array#__get
    i32.const 4
    i32.shr_u
    call $~lib/array/Array<u8>#__set
    local.get $1
    local.get $4
    i32.const 1
    i32.add
    local.get $0
    local.get $2
    call $~lib/typedarray/Uint8Array#__get
    i32.const 15
    i32.and
    call $~lib/array/Array<u8>#__set
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $loop|0
   end
  end
  local.get $1
 )
 (func $~lib/map/Map<usize,main/Node>#get (; 65 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/hash32
  call $~lib/map/Map<usize,main/Node>#find
  local.tee $0
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
 )
 (func $main/uintArrToNibbleArr (; 66 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.load offset=8
  local.tee $1
  local.set $3
  local.get $1
  i32.const 1
  i32.shl
  call $~lib/array/Array.create<u8>
  local.set $1
  loop $loop|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $1
    local.get $2
    i32.const 1
    i32.shl
    local.tee $4
    local.get $0
    local.get $2
    call $~lib/typedarray/Uint8Array#__get
    i32.const 4
    i32.shr_u
    call $~lib/array/Array<u8>#__set
    local.get $1
    local.get $4
    i32.const 1
    i32.add
    local.get $0
    local.get $2
    call $~lib/typedarray/Uint8Array#__get
    i32.const 15
    i32.and
    call $~lib/array/Array<u8>#__set
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $loop|0
   end
  end
  local.get $1
 )
 (func $~lib/array/Array<u8>#slice (; 67 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 2147483647
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 2147483647
  local.get $2
  i32.lt_s
  select
  local.get $1
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $1
   local.get $2
   i32.add
   local.tee $1
   i32.const 0
   local.get $1
   i32.const 0
   i32.gt_s
   select
  else   
   local.get $1
   local.get $2
   local.get $1
   local.get $2
   i32.lt_s
   select
  end
  local.tee $1
  i32.sub
  local.tee $2
  i32.const 0
  local.get $2
  i32.const 0
  i32.gt_s
  select
  local.tee $2
  i32.const 0
  i32.const 6
  i32.const 0
  call $~lib/rt/__allocArray
  local.tee $3
  i32.load offset=4
  local.get $0
  i32.load offset=4
  local.get $1
  i32.add
  local.get $2
  call $~lib/memory/memory.copy
  local.get $3
 )
 (func $~lib/array/Array<u8>#shift (; 68 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=12
  local.tee $1
  i32.const 1
  i32.lt_s
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.tee $2
  i32.load8_u
  local.get $2
  local.get $2
  i32.const 1
  i32.add
  local.get $1
  i32.const 1
  i32.sub
  local.tee $1
  call $~lib/memory/memory.copy
  local.get $1
  local.get $2
  i32.add
  i32.const 0
  i32.store8
  local.get $0
  local.get $1
  i32.store offset=12
 )
 (func $~lib/array/Array<u8>#unshift (; 69 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  i32.const 1
  i32.add
  local.tee $2
  i32.const 0
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.tee $3
  i32.const 1
  i32.add
  local.get $3
  local.get $2
  i32.const 1
  i32.sub
  call $~lib/memory/memory.copy
  local.get $3
  local.get $1
  i32.store8
  local.get $0
  local.get $2
  i32.store offset=12
 )
 (func $main/addHexPrefix (; 70 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.load offset=12
  i32.const 2
  i32.rem_s
  if
   local.get $0
   i32.const 1
   call $~lib/array/Array<u8>#unshift
  else   
   local.get $0
   i32.const 0
   call $~lib/array/Array<u8>#unshift
   local.get $0
   i32.const 0
   call $~lib/array/Array<u8>#unshift
  end
  local.get $0
  i32.const 0
  local.get $0
  i32.const 0
  call $~lib/typedarray/Uint8Array#__get
  i32.const 2
  i32.add
  call $~lib/array/Array<u8>#__set
  local.get $0
 )
 (func $main/nibbleArrToUintArr (; 71 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.load offset=12
  i32.const 2
  i32.div_s
  call $~lib/typedarray/Uint8Array#constructor
  local.set $2
  loop $loop|0
   local.get $1
   local.get $2
   i32.load offset=8
   i32.lt_s
   if
    local.get $1
    i32.const 1
    i32.shl
    local.tee $3
    i32.const 1
    i32.add
    local.set $4
    local.get $2
    local.get $1
    local.get $0
    local.get $3
    call $~lib/typedarray/Uint8Array#__get
    i32.const 4
    i32.shl
    local.get $0
    local.get $4
    call $~lib/typedarray/Uint8Array#__get
    i32.add
    i32.const 255
    i32.and
    call $~lib/typedarray/Uint8Array#__set
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $loop|0
   end
  end
  local.get $2
 )
 (func $~lib/array/Array.create<rlp/RLPData> (; 72 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 268435452
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 11
  i32.const 0
  call $~lib/rt/__allocArray
  local.tee $0
  i32.const 0
  i32.store offset=12
  local.get $0
  i32.load offset=4
  i32.const 0
  local.get $0
  i32.load offset=8
  call $~lib/memory/memory.fill
  local.get $0
 )
 (func $rlp/concatUint8Arrays~anonymous|0 (; 73 ;) (type $FUNCSIG$iiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  local.get $1
  i32.load offset=8
  local.get $0
  i32.add
 )
 (func $~lib/array/Array<~lib/typedarray/Uint8Array>#reduce<u32> (; 74 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.load offset=12
  local.set $3
  loop $loop|0
   local.get $1
   local.get $3
   local.get $0
   i32.load offset=12
   local.tee $4
   local.get $3
   local.get $4
   i32.lt_s
   select
   i32.lt_s
   if
    i32.const 4
    global.set $~lib/argc
    local.get $2
    local.get $0
    i32.load offset=4
    local.get $1
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $1
    local.get $0
    call $rlp/concatUint8Arrays~anonymous|0
    local.set $2
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $loop|0
   end
  end
  local.get $2
 )
 (func $rlp/concatUint8Arrays (; 75 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  call $~lib/array/Array<~lib/typedarray/Uint8Array>#reduce<u32>
  call $~lib/typedarray/Uint8Array#constructor
  local.set $2
  loop $loop|0
   local.get $1
   local.get $0
   i32.load offset=12
   i32.lt_s
   if
    local.get $2
    i32.load
    local.get $2
    call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
    i32.add
    local.get $3
    i32.add
    local.get $0
    local.get $1
    call $~lib/array/Array<rlp/RLPData>#__get
    i32.load
    local.get $0
    i32.const 1
    call $~lib/array/Array<rlp/RLPData>#__get
    call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
    i32.add
    local.get $0
    local.get $1
    call $~lib/array/Array<rlp/RLPData>#__get
    i32.load offset=8
    call $~lib/memory/memory.copy
    local.get $0
    local.get $1
    call $~lib/array/Array<rlp/RLPData>#__get
    i32.load offset=8
    local.get $3
    i32.add
    local.set $3
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $loop|0
   end
  end
  local.get $2
 )
 (func $~lib/dataview/DataView#constructor (; 76 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 2
  local.get $0
  call $~lib/arraybuffer/ArrayBuffer#get:byteLength
  i32.gt_u
  if
   unreachable
  end
  i32.const 12
  i32.const 17
  call $~lib/rt/stub/__alloc
  local.tee $1
  i32.const 0
  i32.store
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  i32.const 0
  i32.store offset=8
  local.get $1
  i32.load
  drop
  local.get $1
  local.get $0
  i32.store
  local.get $1
  local.get $0
  i32.store offset=4
  local.get $1
  i32.const 2
  i32.store offset=8
  local.get $1
 )
 (func $~lib/dataview/DataView#setUint16 (; 77 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  i32.const 2
  local.get $0
  i32.load offset=8
  i32.gt_s
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/polyfills/bswap<u16>
  i32.store16
 )
 (func $rlp/concatUint8Array (; 78 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  i32.load offset=8
  local.get $1
  i32.load offset=8
  i32.add
  call $~lib/typedarray/Uint8Array#constructor
  local.tee $2
  i32.load
  local.get $2
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $0
  i32.load
  local.get $0
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $0
  i32.load offset=8
  call $~lib/memory/memory.copy
  local.get $2
  i32.load
  local.get $2
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $0
  i32.load offset=8
  i32.add
  local.get $1
  i32.load
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $1
  i32.load offset=8
  call $~lib/memory/memory.copy
  local.get $2
 )
 (func $rlp/encodeLength (; 79 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  i32.const 56
  i32.lt_u
  if (result i32)
   local.get $0
   local.get $1
   i32.add
   local.tee $0
   i32.const 256
   i32.lt_u
   if
    i32.const 1
    call $~lib/typedarray/Uint8Array#constructor
    local.tee $1
    i32.const 0
    local.get $0
    i32.const 255
    i32.and
    call $~lib/typedarray/Uint8Array#__set
    local.get $1
    return
   end
   local.get $0
   i32.const 65536
   i32.lt_u
   if
    i32.const 2
    call $~lib/typedarray/Uint8Array#constructor
    local.tee $1
    i32.load
    call $~lib/dataview/DataView#constructor
    local.get $0
    call $~lib/dataview/DataView#setUint16
    local.get $1
    return
   end
   unreachable
  else   
   local.get $0
   i32.const 256
   i32.lt_u
   if (result i32)
    i32.const 1
    call $~lib/typedarray/Uint8Array#constructor
    local.tee $2
    i32.const 0
    local.get $0
    i32.const 255
    i32.and
    call $~lib/typedarray/Uint8Array#__set
    i32.const 1
   else    
    local.get $0
    i32.const 65536
    i32.lt_u
    if
     i32.const 2
     call $~lib/typedarray/Uint8Array#constructor
     local.tee $2
     i32.load
     call $~lib/dataview/DataView#constructor
     local.get $0
     call $~lib/dataview/DataView#setUint16
    else     
     unreachable
    end
    i32.const 2
   end
   local.get $1
   i32.const 55
   i32.add
   i32.add
   local.tee $1
   i32.const 256
   i32.lt_u
   if
    i32.const 1
    call $~lib/typedarray/Uint8Array#constructor
    local.tee $0
    i32.const 0
    local.get $1
    i32.const 255
    i32.and
    call $~lib/typedarray/Uint8Array#__set
   else    
    local.get $1
    i32.const 65536
    i32.lt_u
    if
     i32.const 2
     call $~lib/typedarray/Uint8Array#constructor
     local.tee $0
     i32.load
     call $~lib/dataview/DataView#constructor
     local.get $1
     call $~lib/dataview/DataView#setUint16
    else     
     unreachable
    end
   end
   local.get $0
   local.get $2
   call $rlp/concatUint8Array
  end
 )
 (func $rlp/encode (; 80 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.load offset=4
  i32.load offset=12
  if (result i32)
   i32.const 16
   i32.const 16
   call $~lib/rt/stub/__alloc
   i32.const 0
   i32.const 2
   call $~lib/arraybuffer/ArrayBufferView#constructor
   local.tee $1
   i32.const 0
   i32.store offset=12
   local.get $1
   i32.const 0
   i32.store offset=12
   loop $loop|0
    local.get $2
    local.get $0
    i32.load offset=4
    i32.load offset=12
    i32.lt_s
    if
     local.get $1
     local.get $0
     i32.load offset=4
     local.get $2
     call $~lib/array/Array<rlp/RLPData>#__get
     call $rlp/encode
     call $~lib/array/Array<~lib/string/String>#push
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $loop|0
    end
   end
   local.get $1
   call $rlp/concatUint8Arrays
   local.tee $0
   i32.load offset=8
   i32.const 192
   call $rlp/encodeLength
   local.get $0
   call $rlp/concatUint8Array
  else   
   local.get $0
   i32.load
   i32.load offset=8
   i32.const 1
   i32.eq
   if (result i32)
    local.get $0
    i32.load
    i32.const 0
    call $~lib/typedarray/Uint8Array#__get
    i32.const 128
    i32.lt_u
   else    
    i32.const 0
   end
   if
    local.get $0
    i32.load
    return
   end
   local.get $0
   i32.load
   i32.load offset=8
   i32.const 128
   call $rlp/encodeLength
   local.get $0
   i32.load
   call $rlp/concatUint8Array
  end
 )
 (func $main/createNewBranchWhereLeafExists (; 81 ;) (type $FUNCSIG$viiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  local.get $3
  i32.load offset=8
  call $rlp/decode
  local.tee $3
  i32.load offset=4
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  local.set $7
  local.get $3
  i32.load offset=4
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  call $main/uintArrToNibbleArr
  local.tee $3
  i32.const 0
  call $~lib/typedarray/Uint8Array#__get
  i32.const 1
  i32.and
  if (result i32)
   local.get $3
   i32.const 1
   call $~lib/array/Array<u8>#slice
  else   
   local.get $3
   i32.const 2
   call $~lib/array/Array<u8>#slice
  end
  local.set $3
  local.get $1
  local.get $2
  call $~lib/typedarray/Uint8Array#__get
  local.get $3
  i32.const 0
  call $~lib/typedarray/Uint8Array#__get
  i32.eq
  if
   unreachable
  end
  local.get $3
  call $~lib/array/Array<u8>#shift
  local.set $8
  local.get $3
  call $main/addHexPrefix
  call $main/nibbleArrToUintArr
  local.set $5
  i32.const 2
  call $~lib/array/Array.create<rlp/RLPData>
  local.tee $3
  i32.const 0
  i32.const 0
  call $~lib/array/Array.create<rlp/RLPData>
  call $rlp/RLPData#constructor
  call $~lib/array/Array<~lib/string/String>#push
  local.get $3
  i32.const 0
  i32.const 0
  call $~lib/array/Array.create<rlp/RLPData>
  call $rlp/RLPData#constructor
  call $~lib/array/Array<~lib/string/String>#push
  local.get $3
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $6
  i32.load
  drop
  local.get $6
  local.get $5
  i32.store
  local.get $3
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $5
  i32.load
  drop
  local.get $5
  local.get $7
  i32.store
  i32.const 0
  local.get $3
  call $rlp/RLPData#constructor
  call $rlp/encode
  local.set $3
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $7
  local.get $3
  i32.load
  local.get $3
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $3
  i32.load offset=8
  call $keccak/ethash_keccak256
  i32.const 0
  i32.const 0
  local.get $3
  call $main/Node#constructor
  local.set $3
  global.get $main/Trie
  local.get $7
  local.get $3
  call $~lib/map/Map<usize,main/Node>#set
  local.get $1
  local.get $2
  call $~lib/typedarray/Uint8Array#__get
  local.set $5
  local.get $1
  local.get $2
  i32.const 1
  i32.add
  call $~lib/array/Array<u8>#slice
  call $main/addHexPrefix
  call $main/nibbleArrToUintArr
  local.set $6
  i32.const 2
  call $~lib/array/Array.create<rlp/RLPData>
  local.tee $3
  i32.const 0
  i32.const 0
  call $~lib/array/Array.create<rlp/RLPData>
  call $rlp/RLPData#constructor
  call $~lib/array/Array<~lib/string/String>#push
  local.get $3
  i32.const 0
  i32.const 0
  call $~lib/array/Array.create<rlp/RLPData>
  call $rlp/RLPData#constructor
  call $~lib/array/Array<~lib/string/String>#push
  local.get $3
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $9
  i32.load
  drop
  local.get $9
  local.get $6
  i32.store
  local.get $3
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $6
  i32.load
  drop
  local.get $6
  local.get $0
  i32.store
  i32.const 0
  local.get $3
  call $rlp/RLPData#constructor
  call $rlp/encode
  local.set $0
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $3
  local.get $0
  i32.load
  local.get $0
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $0
  i32.load offset=8
  call $keccak/ethash_keccak256
  i32.const 0
  i32.const 0
  local.get $0
  call $main/Node#constructor
  local.set $0
  global.get $main/Trie
  local.get $3
  local.get $0
  call $~lib/map/Map<usize,main/Node>#set
  i32.const 17
  call $~lib/array/Array<usize>#constructor
  call $rlp/RLPBranchNode#constructor
  local.tee $0
  i32.load
  local.get $8
  local.get $7
  call $~lib/array/Array<usize>#__set
  local.get $0
  i32.load
  local.get $5
  local.get $3
  call $~lib/array/Array<usize>#__set
  local.get $0
  i32.load
  call $rlp/hashBranchNode
  local.set $3
  i32.const 1
  local.get $0
  i32.const 0
  call $main/Node#constructor
  local.set $0
  global.get $main/Trie
  local.get $3
  local.get $0
  call $~lib/map/Map<usize,main/Node>#set
  local.get $4
  local.get $4
  i32.load offset=12
  i32.const 2
  i32.sub
  call $~lib/typedarray/Uint32Array#__get
  local.set $0
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usize,main/Node>#get
  local.get $1
  local.get $2
  i32.const 1
  i32.sub
  call $~lib/typedarray/Uint8Array#__get
  local.set $1
  i32.load offset=4
  i32.load
  local.get $1
  local.get $3
  call $~lib/array/Array<usize>#__set
 )
 (func $main/insertNewLeafNewBranch (; 82 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usize,main/Node>#get
  local.set $3
  i32.const 40
  call $~lib/array/Array.create<usize>
  local.tee $5
  local.get $0
  call $~lib/array/Array<~lib/string/String>#push
  block $folding-inner0
   loop $loop|0
    local.get $4
    i32.const 40
    i32.lt_s
    if
     local.get $1
     local.get $4
     call $~lib/typedarray/Uint8Array#__get
     local.set $6
     local.get $3
     i32.load
     if
      local.get $3
      i32.load
      i32.const 1
      i32.ne
      br_if $folding-inner0
      local.get $3
      i32.load offset=4
      i32.load offset=4
      i32.eqz
      if
       local.get $3
       i32.load offset=4
       local.set $0
       i32.const 16
       call $~lib/array/Array.create<u8>
       local.set $7
       local.get $0
       i32.load offset=4
       drop
       local.get $0
       local.get $7
       i32.store offset=4
      end
      local.get $3
      i32.load offset=4
      i32.load
      local.get $6
      call $~lib/typedarray/Uint32Array#__get
      local.tee $0
      i32.eqz
      br_if $folding-inner0
      local.get $5
      local.get $0
      call $~lib/array/Array<~lib/string/String>#push
      global.get $main/Trie
      local.get $0
      call $~lib/map/Map<usize,main/Node>#get
      local.tee $0
      i32.load
      i32.const 1
      i32.eq
      if
       local.get $3
       i32.load offset=4
       i32.load offset=4
       local.get $6
       call $~lib/array/Array<u8>#push
      else       
       local.get $0
       i32.load
       if
        unreachable
       end
      end
      local.get $0
      local.set $3
      local.get $4
      i32.const 1
      i32.add
      local.set $4
      br $loop|0
     else      
      local.get $2
      local.get $1
      local.get $4
      local.get $3
      local.get $5
      call $main/createNewBranchWhereLeafExists
      return
     end
     unreachable
    end
   end
   return
  end
  unreachable
 )
 (func $main/rehashNode (; 83 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usize,main/Node>#get
  local.tee $0
  i32.load
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.load
  i32.const 1
  i32.eq
  if
   local.get $0
   i32.load offset=4
   i32.load offset=4
   local.tee $2
   i32.eqz
   if
    unreachable
   end
   loop $loop|0
    local.get $1
    local.get $2
    i32.load offset=12
    i32.lt_s
    if
     local.get $2
     local.get $1
     call $~lib/typedarray/Uint8Array#__get
     local.set $3
     local.get $0
     i32.load offset=4
     i32.load
     local.get $3
     call $~lib/typedarray/Uint32Array#__get
     call $main/rehashNode
     local.set $4
     local.get $0
     i32.load offset=4
     i32.load
     local.get $3
     local.get $4
     call $~lib/array/Array<usize>#__set
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $loop|0
    end
   end
   local.get $0
   i32.load offset=4
   i32.load
   call $rlp/hashBranchNode
   local.set $1
   global.get $main/Trie
   local.get $1
   local.get $0
   call $~lib/map/Map<usize,main/Node>#set
   local.get $1
   return
  end
  unreachable
 )
 (func $main/main (; 84 ;) (type $FUNCSIG$i) (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  i32.const 650
  call $~lib/arraybuffer/ArrayBuffer#constructor
  drop
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $0
  call $~lib/typedarray/Uint64Array.wrap
  local.set $7
  local.get $0
  call $main/eth2_loadPreStateRoot
  call $main/eth2_blockDataSize
  local.tee $0
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $2
  i32.const 0
  local.get $0
  call $main/eth2_blockDataCopy
  local.get $2
  local.get $0
  call $~lib/typedarray/Uint8Array.wrap
  call $rlp/decode
  local.tee $0
  i32.load offset=4
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  local.get $0
  i32.load offset=4
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  local.set $2
  local.get $0
  i32.load offset=4
  i32.const 2
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  local.set $6
  local.get $2
  i32.load
  local.get $2
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.set $13
  i32.load
  call $rlp/decode
  i32.load offset=4
  local.set $14
  i32.const 12
  i32.const 15
  call $~lib/rt/stub/__alloc
  i32.const 100
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.set $5
  loop $continue|0
   local.get $1
   local.get $6
   i32.load offset=8
   i32.lt_s
   if
    local.get $6
    local.get $1
    call $~lib/typedarray/Uint8Array#__get
    local.set $0
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    block $break|1
     block $case2|1
      block $case1|1
       local.get $0
       i32.const 128
       i32.ne
       if
        local.get $0
        i32.const 129
        i32.eq
        br_if $case1|1
        local.get $0
        i32.const 130
        i32.eq
        br_if $case2|1
        br $break|1
       end
       local.get $14
       local.get $9
       call $~lib/array/Array<rlp/RLPData>#__get
       i32.load
       local.set $0
       local.get $9
       i32.const 1
       i32.add
       local.set $9
       i32.const 32
       call $~lib/arraybuffer/ArrayBuffer#constructor
       local.tee $2
       local.get $0
       i32.load
       local.get $0
       call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
       i32.add
       local.get $0
       i32.load offset=8
       call $keccak/ethash_keccak256
       i32.const 0
       i32.const 0
       local.get $0
       call $main/Node#constructor
       local.set $0
       global.get $main/Trie
       local.get $2
       local.get $0
       call $~lib/map/Map<usize,main/Node>#set
       local.get $5
       local.get $3
       local.get $2
       call $~lib/typedarray/Uint32Array#__set
       local.get $3
       i32.const 1
       i32.add
       local.set $3
       local.get $1
       i32.const 1
       i32.add
       local.set $1
       br $break|1
      end
      local.get $6
      local.get $1
      call $~lib/typedarray/Uint8Array#__get
      local.set $2
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      local.get $2
      call $~lib/array/Array<u8>#constructor
      local.set $4
      i32.const 0
      local.set $0
      loop $loop|2
       local.get $0
       local.get $2
       i32.lt_s
       if
        local.get $4
        local.get $0
        local.get $6
        local.get $1
        call $~lib/typedarray/Uint8Array#__get
        call $~lib/array/Array<u8>#__set
        local.get $1
        i32.const 1
        i32.add
        local.set $1
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $loop|2
       end
      end
      local.get $2
      call $~lib/array/Array<u8>#constructor
      local.set $10
      local.get $2
      call $~lib/array/Array<usize>#constructor
      local.set $11
      i32.const 0
      local.set $0
      loop $loop|3
       local.get $0
       local.get $2
       i32.lt_s
       if
        local.get $10
        local.get $0
        local.get $4
        local.get $2
        i32.const 1
        i32.sub
        local.get $0
        i32.sub
        local.tee $8
        call $~lib/typedarray/Uint8Array#__get
        call $~lib/array/Array<u8>#__set
        local.get $11
        local.get $8
        local.get $5
        local.get $3
        i32.const 1
        i32.sub
        local.tee $3
        call $~lib/typedarray/Uint32Array#__get
        call $~lib/array/Array<usize>#__set
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $loop|3
       end
      end
      i32.const 17
      call $~lib/array/Array<usize>#constructor
      call $rlp/RLPBranchNode#constructor
      local.set $4
      i32.const 0
      local.set $0
      loop $loop|4
       local.get $0
       local.get $2
       i32.lt_s
       if
        local.get $10
        local.get $0
        call $~lib/typedarray/Uint8Array#__get
        local.set $8
        local.get $4
        i32.load
        local.get $8
        local.get $11
        local.get $0
        call $~lib/typedarray/Uint32Array#__get
        call $~lib/array/Array<usize>#__set
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $loop|4
       end
      end
      i32.const 1
      local.get $4
      i32.const 0
      call $main/Node#constructor
      local.set $2
      local.get $4
      i32.load
      call $rlp/hashBranchNode
      local.set $0
      global.get $main/Trie
      local.get $0
      local.get $2
      call $~lib/map/Map<usize,main/Node>#set
      local.get $5
      local.get $3
      local.get $0
      call $~lib/typedarray/Uint32Array#__set
      local.get $3
      i32.const 1
      i32.add
      local.set $3
      br $break|1
     end
     local.get $6
     local.get $1
     call $~lib/typedarray/Uint8Array#__get
     local.set $2
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     i32.const 0
     local.set $0
     loop $loop|5
      local.get $0
      local.get $2
      i32.lt_s
      if
       local.get $12
       i32.const 5
       i32.shl
       local.get $13
       i32.add
       local.set $4
       local.get $12
       i32.const 1
       i32.add
       local.set $12
       local.get $5
       local.get $3
       local.get $4
       call $~lib/typedarray/Uint32Array#__set
       local.get $3
       i32.const 1
       i32.add
       local.set $3
       local.get $0
       i32.const 1
       i32.add
       local.set $0
       br $loop|5
      end
     end
    end
    br $continue|0
   end
  end
  local.get $5
  local.get $3
  i32.const 1
  i32.sub
  call $~lib/typedarray/Uint32Array#__get
  local.set $0
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $1
  local.get $0
  i32.const 32
  call $~lib/memory/memory.copy
  local.get $1
  call $~lib/typedarray/Uint64Array.wrap
  local.tee $1
  i32.const 0
  call $~lib/typedarray/Uint64Array#__get
  local.get $7
  i32.const 0
  call $~lib/typedarray/Uint64Array#__get
  i64.ne
  if (result i32)
   i32.const 1
  else   
   local.get $1
   i32.const 1
   call $~lib/typedarray/Uint64Array#__get
   local.get $7
   i32.const 1
   call $~lib/typedarray/Uint64Array#__get
   i64.ne
  end
  if (result i32)
   i32.const 1
  else   
   local.get $1
   i32.const 2
   call $~lib/typedarray/Uint64Array#__get
   local.get $7
   i32.const 2
   call $~lib/typedarray/Uint64Array#__get
   i64.ne
  end
  if (result i32)
   i32.const 1
  else   
   local.get $1
   i32.const 3
   call $~lib/typedarray/Uint64Array#__get
   local.get $7
   i32.const 3
   call $~lib/typedarray/Uint64Array#__get
   i64.ne
  end
  if
   unreachable
  end
  i32.const 32
  call $~lib/array/Array.create<u8>
  drop
  i32.const 32
  i32.const 0
  i32.const 6
  i32.const 10184
  call $~lib/rt/__allocArray
  call $main/u8ArrToNibbleArr
  local.set $1
  i32.const 73
  call $~lib/array/Array.create<u8>
  drop
  local.get $0
  local.get $1
  i32.const 73
  i32.const 0
  i32.const 6
  i32.const 10232
  call $~lib/rt/__allocArray
  i32.load
  i32.const 73
  call $~lib/typedarray/Uint8Array.wrap
  call $main/insertNewLeafNewBranch
  local.get $0
  call $main/rehashNode
  call $main/eth2_savePostStateRoot
  i32.const 1
 )
 (func $start (; 85 ;) (type $FUNCSIG$v)
  i32.const 10320
  global.set $~lib/rt/stub/startOffset
  global.get $~lib/rt/stub/startOffset
  global.set $~lib/rt/stub/offset
  call $~lib/map/Map<usize,main/Node>#constructor
  global.set $main/Trie
 )
 (func $null (; 86 ;) (type $FUNCSIG$v)
  nop
 )
)
