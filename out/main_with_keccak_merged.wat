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
 (import "env" "debug_log" (func $rlp/debug (param i32)))
 (import "env" "debug_mem" (func $rlp/debug_mem (param i32 i32)))
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
 (func $~lib/rt/stub/__alloc (; 9 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/memory/memory.fill (; 10 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/arraybuffer/ArrayBuffer#constructor (; 11 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/map/Map<usizemain/Node>#clear (; 12 ;) (type $FUNCSIG$vi) (param $0 i32)
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
 (func $~lib/map/Map<usizemain/Node>#constructor (; 13 ;) (type $FUNCSIG$i) (result i32)
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
  call $~lib/map/Map<usizemain/Node>#clear
  local.get $0
 )
 (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (; 14 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 16
  i32.sub
  i32.load offset=12
 )
 (func $~lib/typedarray/Uint64Array.wrap (; 15 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/typedarray/Uint8Array.wrap (; 16 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/typedarray/Uint8Array#__get (; 17 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $rlp/Decoded#constructor (; 18 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/arraybuffer/ArrayBufferView#constructor (; 19 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
 (func $~lib/typedarray/Uint8Array#constructor (; 20 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  i32.const 12
  i32.const 7
  call $~lib/rt/stub/__alloc
  local.get $0
  i32.const 0
  call $~lib/arraybuffer/ArrayBufferView#constructor
 )
 (func $rlp/RLPData#constructor (; 21 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/typedarray/Uint8Array#subarray (; 22 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
 (func $~lib/string/String#get:length (; 23 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 16
  i32.sub
  i32.load offset=12
  i32.const 1
  i32.shr_u
 )
 (func $~lib/string/String#charAt (; 24 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/memory/memory.copy (; 25 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/rt/stub/__realloc (; 26 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/array/ensureSize (; 27 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/array/Array<~lib/string/String>#push (; 28 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
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
 (func $~lib/array/Array<~lib/string/String>#reverse (; 29 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<~lib/string/String>#join_str (; 30 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/string/String#concat (; 31 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $rlp/intToHex (; 32 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/string/String#charCodeAt (; 33 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/typedarray/Uint8Array#__set (; 34 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/arraybuffer/ArrayBufferView#get:byteOffset (; 35 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.load offset=4
  local.get $0
  i32.load
  i32.sub
 )
 (func $~lib/string/String.UTF8.decodeUnsafe (; 36 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $rlp/bytesToHex (; 37 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/string/String#slice (; 38 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/util/string/compareImpl (; 39 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/string/String.__eq (; 40 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/util/string/isSpace (; 41 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/util/string/strtol<i32> (; 42 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $rlp/safeParseInt (; 43 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  call $~lib/string/String#slice
  call $~lib/string/String.__eq
  if
   unreachable
  end
  local.get $0
  call $~lib/util/string/strtol<i32>
 )
 (func $~lib/rt/__allocArray (; 44 ;) (type $FUNCSIG$iiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
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
 (func $rlp/_decode (; 45 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $rlp/decode (; 46 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<rlp/RLPData>#__get (; 47 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $main/Node#constructor (; 48 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
 (func $~lib/util/hash/hash32 (; 49 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/map/Map<usizemain/Node>#find (; 50 ;) (type $FUNCSIG$iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
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
 (func $~lib/map/Map<usizemain/Node>#rehash (; 51 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
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
 (func $~lib/map/Map<usizemain/Node>#set (; 52 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/hash32
  local.tee $4
  call $~lib/map/Map<usizemain/Node>#find
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
    call $~lib/map/Map<usizemain/Node>#rehash
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
 (func $~lib/typedarray/Uint32Array#__set (; 53 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/array/Array<u8>#constructor (; 54 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<u8>#__set (; 55 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/array/Array<usize>#constructor (; 56 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/typedarray/Uint32Array#__get (; 57 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/array/Array<usize>#__set (; 58 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
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
 (func $~lib/array/Array.create<rlp/RLPData> (; 59 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $rlp/RLPBranchNode#constructor (; 60 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<rlp/RLPData>#__set (; 61 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  local.tee $3
  i32.gt_u
  if
   unreachable
  end
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
  local.tee $4
  i32.load
  local.get $2
  i32.ne
  if
   local.get $4
   local.get $2
   i32.store
  end
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
 (func $rlp/concatUint8Arrays~anonymous|0 (; 62 ;) (type $FUNCSIG$iiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  local.get $1
  i32.load offset=8
  local.get $0
  i32.add
 )
 (func $~lib/array/Array<~lib/typedarray/Uint8Array>#reduce<u32> (; 63 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $rlp/concatUint8Arrays (; 64 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/dataview/DataView#constructor (; 65 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/polyfills/bswap<u16> (; 66 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/dataview/DataView#setUint16 (; 67 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
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
 (func $rlp/concatUint8Array (; 68 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $rlp/encodeLength (; 69 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  i32.const 56
  i32.lt_u
  if (result i32)
   i32.const 55
   call $rlp/debug
   local.get $0
   local.get $1
   i32.add
   local.tee $0
   call $rlp/debug
   local.get $0
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
   i32.const 56
   call $rlp/debug
   i32.const 561
   call $rlp/debug
   local.get $0
   call $rlp/debug
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
   local.set $0
   i32.const 562
   call $rlp/debug
   local.get $1
   i32.const 55
   i32.add
   local.get $0
   i32.add
   local.tee $1
   call $rlp/debug
   local.get $1
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
 (func $rlp/encode (; 70 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  i32.const 202020
  call $rlp/debug
  local.get $0
  i32.load offset=4
  i32.load offset=12
  if (result i32)
   i32.const 21
   call $rlp/debug
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
     i32.const 22
     call $rlp/debug
     local.get $2
     call $rlp/debug
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
   i32.const 23
   call $rlp/debug
   local.get $0
   i32.load
   i32.load
   local.get $0
   i32.load
   call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
   i32.add
   local.get $0
   i32.load
   i32.load offset=8
   call $rlp/debug_mem
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
   local.tee $1
   i32.load offset=8
   local.set $2
   local.get $1
   i32.load offset=4
   local.get $2
   call $rlp/debug_mem
   local.get $1
   local.get $0
   i32.load
   call $rlp/concatUint8Array
  end
 )
 (func $~lib/typedarray/Uint64Array#__get (; 71 ;) (type $FUNCSIG$jii) (param $0 i32) (param $1 i32) (result i64)
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
 (func $~lib/array/Array.create<u8> (; 72 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $main/u8ArrToNibbleArr (; 73 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/map/Map<usizemain/Node>#get (; 74 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  local.get $1
  call $~lib/util/hash/hash32
  call $~lib/map/Map<usizemain/Node>#find
  local.tee $0
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
 )
 (func $~lib/array/Array.create<usize> (; 75 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $main/uintArrToNibbleArr (; 76 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<u8>#slice (; 77 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
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
 (func $~lib/array/Array<u8>#shift (; 78 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<u8>#unshift (; 79 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
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
 (func $main/addHexPrefix (; 80 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $main/nibbleArrToUintArr (; 81 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
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
 (func $~lib/array/Array<u8>#push (; 82 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
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
 (func $rlp/hashBranchNode (; 83 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 30303
  call $rlp/debug
  i32.const 17
  call $~lib/array/Array.create<u8>
  local.set $4
  i32.const 17
  call $~lib/array/Array.create<usize>
  local.set $7
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
     local.get $7
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
   local.tee $6
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
   local.tee $6
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
     local.get $7
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
  i32.const 40403
  call $rlp/debug
  local.get $1
  local.get $6
  call $rlp/debug_mem
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $0
  local.get $1
  local.get $6
  call $keccak/ethash_keccak256
  i32.const 40404
  call $rlp/debug
  local.get $0
  i32.const 32
  call $rlp/debug_mem
  local.get $0
 )
 (func $main/createNewBranchWhereLeafExists (; 84 ;) (type $FUNCSIG$viiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  i32.const 777
  call $main/debug
  local.get $0
  i32.load
  local.get $0
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $0
  i32.load offset=8
  call $main/debug_mem
  local.get $3
  i32.load offset=8
  call $rlp/decode
  local.set $3
  i32.const 7771
  call $main/debug
  local.get $3
  i32.load offset=4
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  local.tee $5
  i32.load
  local.get $5
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $5
  i32.load offset=8
  call $main/debug_mem
  local.get $3
  i32.load offset=4
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  i32.load
  call $main/uintArrToNibbleArr
  local.set $3
  i32.const 7772
  call $main/debug
  local.get $3
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
  i32.const 7773
  call $main/debug
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
  i32.const 7774
  call $main/debug
  local.get $3
  call $main/addHexPrefix
  call $main/nibbleArrToUintArr
  local.set $6
  i32.const 7775
  call $main/debug
  i32.const 2
  call $~lib/array/Array.create<rlp/RLPData>
  local.set $3
  i32.const 7776
  call $main/debug
  local.get $3
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
  i32.const 7777
  call $main/debug
  local.get $3
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $7
  i32.load
  drop
  local.get $7
  local.get $6
  i32.store
  local.get $3
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $6
  i32.load
  drop
  local.get $6
  local.get $5
  i32.store
  i32.const 7777
  call $main/debug
  i32.const 0
  local.get $3
  call $rlp/RLPData#constructor
  i32.const 7778
  call $main/debug
  call $rlp/encode
  local.set $3
  i32.const 7779
  call $main/debug
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $5
  local.get $3
  i32.load
  local.get $3
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $3
  i32.load offset=8
  call $keccak/ethash_keccak256
  i32.const 7780
  call $main/debug
  local.get $5
  i32.const 32
  call $main/debug_mem
  i32.const 0
  i32.const 0
  local.get $3
  call $main/Node#constructor
  local.set $3
  i32.const 77801
  call $main/debug
  global.get $main/Trie
  local.get $5
  local.get $3
  call $~lib/map/Map<usizemain/Node>#set
  i32.const 77802
  call $main/debug
  local.get $1
  local.get $2
  call $~lib/typedarray/Uint8Array#__get
  local.set $6
  local.get $1
  local.get $2
  i32.const 1
  i32.add
  call $~lib/array/Array<u8>#slice
  call $main/addHexPrefix
  call $main/nibbleArrToUintArr
  local.set $7
  i32.const 7781
  call $main/debug
  i32.const 2
  call $~lib/array/Array.create<rlp/RLPData>
  local.set $3
  i32.const 7782
  call $main/debug
  local.get $3
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
  i32.const 7783
  call $main/debug
  local.get $3
  i32.const 0
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $9
  i32.load
  drop
  local.get $9
  local.get $7
  i32.store
  local.get $3
  i32.const 1
  call $~lib/array/Array<rlp/RLPData>#__get
  local.tee $7
  i32.load
  drop
  local.get $7
  local.get $0
  i32.store
  i32.const 0
  local.get $3
  call $rlp/RLPData#constructor
  call $rlp/encode
  local.set $0
  i32.const 7784
  call $main/debug
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
  i32.const 7785
  call $main/debug
  local.get $3
  i32.const 32
  call $main/debug_mem
  i32.const 0
  i32.const 0
  local.get $0
  call $main/Node#constructor
  local.set $0
  i32.const 77851
  call $main/debug
  global.get $main/Trie
  local.get $3
  local.get $0
  call $~lib/map/Map<usizemain/Node>#set
  i32.const 77852
  call $main/debug
  i32.const 17
  call $~lib/array/Array<usize>#constructor
  call $rlp/RLPBranchNode#constructor
  local.tee $0
  i32.load
  local.get $8
  local.get $5
  call $~lib/array/Array<usize>#__set
  local.get $0
  i32.load
  local.get $6
  local.get $3
  call $~lib/array/Array<usize>#__set
  i32.const 77841
  call $main/debug
  local.get $0
  i32.load
  call $rlp/hashBranchNode
  local.set $3
  i32.const 77842
  call $main/debug
  i32.const 1
  local.get $0
  i32.const 0
  call $main/Node#constructor
  local.set $0
  i32.const 77843
  call $main/debug
  global.get $main/Trie
  local.get $3
  local.get $0
  call $~lib/map/Map<usizemain/Node>#set
  i32.const 77844
  call $main/debug
  local.get $4
  local.get $4
  i32.load offset=12
  i32.const 2
  i32.sub
  call $~lib/typedarray/Uint32Array#__get
  local.set $0
  i32.const 77853
  call $main/debug
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usizemain/Node>#get
  i32.const 77854
  call $main/debug
  local.get $1
  local.get $2
  i32.const 1
  i32.sub
  call $~lib/typedarray/Uint8Array#__get
  local.set $1
  i32.const 77855
  call $main/debug
  i32.load offset=4
  i32.load
  local.get $1
  local.get $3
  call $~lib/array/Array<usize>#__set
  i32.const 77856
  call $main/debug
 )
 (func $main/insertNewLeafNewBranch (; 85 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  i32.const 889
  call $main/debug
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usizemain/Node>#get
  local.set $3
  i32.const 40
  call $~lib/array/Array.create<usize>
  local.tee $5
  local.get $0
  call $~lib/array/Array<~lib/string/String>#push
  i32.const 8892
  call $main/debug
  block $folding-inner0
   loop $loop|0
    local.get $4
    i32.const 40
    i32.lt_s
    if
     i32.const 88933
     call $main/debug
     local.get $1
     local.get $4
     call $~lib/typedarray/Uint8Array#__get
     local.tee $6
     call $main/debug
     local.get $3
     i32.load
     if
      local.get $3
      i32.load
      i32.const 1
      i32.ne
      br_if $folding-inner0
      i32.const 8895
      call $main/debug
      local.get $3
      i32.load offset=4
      i32.load offset=4
      i32.eqz
      if
       i32.const 8896
       call $main/debug
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
      i32.const 88951
      call $main/debug
      local.get $3
      i32.load offset=4
      i32.load
      local.get $6
      call $~lib/typedarray/Uint32Array#__get
      local.tee $0
      i32.const 32
      call $main/debug_mem
      i32.const 88952
      call $main/debug
      local.get $0
      i32.eqz
      br_if $folding-inner0
      local.get $5
      local.get $0
      call $~lib/array/Array<~lib/string/String>#push
      i32.const 88953
      call $main/debug
      global.get $main/Trie
      local.get $0
      call $~lib/map/Map<usizemain/Node>#get
      local.set $0
      i32.const 88954
      call $main/debug
      local.get $0
      i32.load
      i32.const 1
      i32.eq
      if
       i32.const 88955
       call $main/debug
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
       else        
        i32.const 88956
        call $main/debug
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
      i32.const 8894
      call $main/debug
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
 (func $main/rehashNode (; 86 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  i32.const 909081
  call $main/debug
  local.get $0
  i32.const 32
  call $main/debug_mem
  global.get $main/Trie
  local.get $0
  call $~lib/map/Map<usizemain/Node>#get
  local.tee $0
  i32.load
  i32.eqz
  if
   i32.const 909082
   call $main/debug
   unreachable
  end
  i32.const 909083
  call $main/debug
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
    i32.const 909084
    call $main/debug
    unreachable
   end
   i32.const 909011
   call $main/debug
   local.get $2
   i32.load offset=12
   call $main/debug
   loop $loop|0
    local.get $1
    local.get $2
    i32.load offset=12
    i32.lt_s
    if
     i32.const 909012
     call $main/debug
     local.get $2
     local.get $1
     call $~lib/typedarray/Uint8Array#__get
     call $main/debug
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $loop|0
    end
   end
   i32.const 0
   local.set $1
   loop $loop|1
    local.get $1
    local.get $2
    i32.load offset=12
    i32.lt_s
    if
     i32.const 909085
     call $main/debug
     local.get $2
     local.get $1
     call $~lib/typedarray/Uint8Array#__get
     local.tee $3
     call $main/debug
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
     br $loop|1
    end
   end
   i32.const 909086
   call $main/debug
   local.get $0
   i32.load offset=4
   i32.load
   call $rlp/hashBranchNode
   local.set $1
   i32.const 909087
   call $main/debug
   global.get $main/Trie
   local.get $1
   local.get $0
   call $~lib/map/Map<usizemain/Node>#set
   i32.const 909088
   call $main/debug
   local.get $1
   return
  end
  i32.const 909089
  call $main/debug
  unreachable
 )
 (func $main/main (; 87 ;) (type $FUNCSIG$i) (result i32)
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
  (local $15 i32)
  (local $16 i32)
  i32.const 650
  call $~lib/arraybuffer/ArrayBuffer#constructor
  drop
  i32.const 32
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $0
  call $~lib/typedarray/Uint64Array.wrap
  local.set $8
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
  local.set $5
  local.get $2
  i32.load
  local.get $2
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.set $15
  i32.load
  call $rlp/decode
  i32.load offset=4
  local.set $16
  i32.const 12
  i32.const 15
  call $~lib/rt/stub/__alloc
  i32.const 100
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.set $6
  loop $continue|0
   local.get $1
   local.get $5
   i32.load offset=8
   i32.lt_s
   if
    local.get $5
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
       i32.const 80
       call $main/debug
       local.get $16
       local.get $10
       call $~lib/array/Array<rlp/RLPData>#__get
       local.get $10
       i32.const 1
       i32.add
       local.set $10
       i32.load
       local.tee $0
       i32.load
       local.get $0
       call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
       i32.add
       local.get $0
       i32.load offset=8
       call $main/debug_mem
       i32.const 81
       call $main/debug
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
       local.get $2
       i32.const 32
       call $main/debug_mem
       local.get $2
       i32.const 32
       call $~lib/typedarray/Uint8Array.wrap
       drop
       i32.const 881
       call $main/debug
       i32.const 0
       i32.const 0
       local.get $0
       call $main/Node#constructor
       local.set $0
       i32.const 882
       call $main/debug
       global.get $main/Trie
       local.get $2
       local.get $0
       call $~lib/map/Map<usizemain/Node>#set
       i32.const 883
       call $main/debug
       local.get $6
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
      i32.const 81
      call $main/debug
      local.get $5
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
        local.get $5
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
      local.set $11
      local.get $2
      call $~lib/array/Array<usize>#constructor
      local.set $9
      i32.const 0
      local.set $0
      loop $loop|3
       local.get $0
       local.get $2
       i32.lt_s
       if
        local.get $11
        local.get $0
        local.get $4
        local.get $2
        i32.const 1
        i32.sub
        local.get $0
        i32.sub
        local.tee $7
        call $~lib/typedarray/Uint8Array#__get
        call $~lib/array/Array<u8>#__set
        local.get $9
        local.get $7
        local.get $6
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
      i32.const 811
      call $main/debug
      i32.const 17
      call $~lib/array/Array.create<rlp/RLPData>
      local.set $0
      i32.const 812
      call $main/debug
      i32.const 0
      local.get $0
      call $rlp/RLPData#constructor
      local.set $7
      i32.const 17
      call $~lib/array/Array<usize>#constructor
      call $rlp/RLPBranchNode#constructor
      local.set $12
      i32.const 813
      call $main/debug
      i32.const 0
      local.set $0
      loop $loop|4
       local.get $0
       i32.const 17
       i32.lt_s
       if
        local.get $0
        call $main/debug
        local.get $7
        i32.load offset=4
        i32.const 0
        i32.const 0
        call $~lib/array/Array.create<rlp/RLPData>
        call $rlp/RLPData#constructor
        call $~lib/array/Array<~lib/string/String>#push
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $loop|4
       end
      end
      i32.const 814
      call $main/debug
      i32.const 0
      local.set $0
      loop $loop|5
       local.get $0
       local.get $2
       i32.lt_s
       if
        local.get $0
        call $main/debug
        local.get $11
        local.get $0
        call $~lib/typedarray/Uint8Array#__get
        local.set $13
        i32.const 32
        call $~lib/typedarray/Uint8Array#constructor
        local.set $4
        i32.const 81411
        call $main/debug
        local.get $9
        local.get $0
        call $~lib/typedarray/Uint32Array#__get
        i32.const 32
        call $main/debug_mem
        local.get $4
        i32.load
        local.get $4
        call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
        i32.add
        local.get $9
        local.get $0
        call $~lib/typedarray/Uint32Array#__get
        i32.const 32
        call $~lib/memory/memory.copy
        i32.const 81412
        call $main/debug
        local.get $4
        i32.load
        local.get $4
        call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
        i32.add
        local.get $4
        i32.load offset=8
        call $main/debug_mem
        local.get $7
        i32.load offset=4
        local.get $13
        local.get $4
        i32.const 0
        call $rlp/RLPData#constructor
        call $~lib/array/Array<rlp/RLPData>#__set
        local.get $12
        i32.load
        local.get $13
        local.get $9
        local.get $0
        call $~lib/typedarray/Uint32Array#__get
        call $~lib/array/Array<usize>#__set
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $loop|5
       end
      end
      i32.const 815
      call $main/debug
      local.get $7
      call $rlp/encode
      local.set $0
      i32.const 816
      call $main/debug
      local.get $0
      i32.load
      local.get $0
      call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
      i32.add
      local.get $0
      i32.load offset=8
      call $main/debug_mem
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
      i32.const 333
      call $main/debug
      local.get $2
      i32.const 32
      call $main/debug_mem
      i32.const 444
      call $main/debug
      i32.const 1
      local.get $12
      i32.const 0
      call $main/Node#constructor
      local.set $0
      i32.const 445
      call $main/debug
      global.get $main/Trie
      local.get $2
      local.get $0
      call $~lib/map/Map<usizemain/Node>#set
      i32.const 446
      call $main/debug
      local.get $6
      local.get $3
      local.get $2
      call $~lib/typedarray/Uint32Array#__set
      local.get $3
      i32.const 1
      i32.add
      local.set $3
      br $break|1
     end
     i32.const 82
     call $main/debug
     local.get $5
     local.get $1
     call $~lib/typedarray/Uint8Array#__get
     local.set $2
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     i32.const 0
     local.set $0
     loop $loop|6
      local.get $0
      local.get $2
      i32.lt_s
      if
       local.get $14
       i32.const 5
       i32.shl
       local.get $15
       i32.add
       local.set $4
       local.get $14
       i32.const 1
       i32.add
       local.set $14
       local.get $6
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
       br $loop|6
      end
     end
    end
    br $continue|0
   end
  end
  local.get $6
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
  local.get $8
  i32.const 0
  call $~lib/typedarray/Uint64Array#__get
  i64.ne
  if (result i32)
   i32.const 1
  else   
   local.get $1
   i32.const 1
   call $~lib/typedarray/Uint64Array#__get
   local.get $8
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
   local.get $8
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
   local.get $8
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
  local.tee $1
  i32.load
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $1
  i32.load offset=8
  call $main/debug_mem
  i32.const 20
  call $~lib/array/Array.create<u8>
  drop
  i32.const 73
  i32.const 0
  i32.const 6
  i32.const 10232
  call $~lib/rt/__allocArray
  i32.load
  i32.const 73
  call $~lib/typedarray/Uint8Array.wrap
  local.tee $3
  i32.load
  local.get $3
  call $~lib/arraybuffer/ArrayBufferView#get:byteOffset
  i32.add
  local.get $3
  i32.load offset=8
  call $main/debug_mem
  local.get $0
  local.get $1
  local.get $3
  call $main/insertNewLeafNewBranch
  i32.const 90908
  call $main/debug
  local.get $0
  call $main/rehashNode
  local.set $0
  i32.const 90909
  call $main/debug
  local.get $0
  i32.const 32
  call $main/debug_mem
  local.get $0
  call $main/eth2_savePostStateRoot
  i32.const 1
 )
 (func $start (; 88 ;) (type $FUNCSIG$v)
  i32.const 10320
  global.set $~lib/rt/stub/startOffset
  global.get $~lib/rt/stub/startOffset
  global.set $~lib/rt/stub/offset
  call $~lib/map/Map<usizemain/Node>#constructor
  global.set $main/Trie
 )
 (func $null (; 89 ;) (type $FUNCSIG$v)
  nop
 )

  ;; ethash_keccakf1600
  (func $ethash_keccakf1600 (param $p0 i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i64) (local $l4 i64) (local $l5 i64) (local $l6 i64) (local $l7 i64) (local $l8 i64) (local $l9 i64) (local $l10 i64) (local $l11 i64) (local $l12 i64) (local $l13 i64) (local $l14 i64) (local $l15 i64) (local $l16 i64) (local $l17 i64) (local $l18 i64) (local $l19 i64) (local $l20 i64) (local $l21 i64) (local $l22 i64) (local $l23 i64) (local $l24 i64) (local $l25 i64) (local $l26 i64) (local $l27 i64) (local $l28 i64) (local $l29 i64) (local $l30 i64) (local $l31 i64) (local $l32 i64) (local $l33 i64) (local $l34 i64) (local $l35 i64) (local $l36 i64) (local $l37 i64) (local $l38 i64) (local $l39 i64) (local $l40 i64) (local $l41 i64) (local $l42 i64) (local $l43 i64) (local $l44 i64) (local $l45 i64) (local $l46 i64) (local $l47 i64) (local $l48 i64) (local $l49 i64) (local $l50 i64) (local $l51 i64)
    (local.set $l20
      (i64.load
        (local.get $p0)))
    (local.set $l21
      (i64.load offset=8
        (local.get $p0)))
    (local.set $l37
      (i64.load offset=16
        (local.get $p0)))
    (local.set $l22
      (i64.load offset=24
        (local.get $p0)))
    (local.set $l23
      (i64.load offset=32
        (local.get $p0)))
    (local.set $l24
      (i64.load offset=40
        (local.get $p0)))
    (local.set $l11
      (i64.load offset=48
        (local.get $p0)))
    (local.set $l25
      (i64.load offset=56
        (local.get $p0)))
    (local.set $l26
      (i64.load
        (local.tee $l2
          (i32.sub
            (local.get $p0)
            (i32.const -64)))))
    (local.set $l14
      (i64.load offset=72
        (local.get $p0)))
    (local.set $l15
      (i64.load offset=80
        (local.get $p0)))
    (local.set $l27
      (i64.load offset=88
        (local.get $p0)))
    (local.set $l8
      (i64.load offset=96
        (local.get $p0)))
    (local.set $l16
      (i64.load offset=104
        (local.get $p0)))
    (local.set $l17
      (i64.load offset=112
        (local.get $p0)))
    (local.set $l32
      (i64.load offset=120
        (local.get $p0)))
    (local.set $l19
      (i64.load offset=128
        (local.get $p0)))
    (local.set $l12
      (i64.load offset=136
        (local.get $p0)))
    (local.set $l10
      (i64.load offset=144
        (local.get $p0)))
    (local.set $l4
      (i64.load offset=152
        (local.get $p0)))
    (local.set $l9
      (i64.load offset=160
        (local.get $p0)))
    (local.set $l33
      (i64.load offset=168
        (local.get $p0)))
    (local.set $l6
      (i64.load offset=176
        (local.get $p0)))
    (local.set $l5
      (i64.load offset=184
        (local.get $p0)))
    (local.set $l3
      (i64.load offset=192
        (local.get $p0)))
    (loop $L0
      (local.set $l36
        (i64.xor
          (local.tee $l35
            (i64.xor
              (local.get $l23)
              (i64.xor
                (local.get $l14)
                (i64.xor
                  (local.get $l17)
                  (i64.xor
                    (local.get $l3)
                    (local.get $l4))))))
          (i64.or
            (i64.shl
              (local.tee $l34
                (i64.xor
                  (local.get $l21)
                  (i64.xor
                    (local.get $l11)
                    (i64.xor
                      (local.get $l27)
                      (i64.xor
                        (local.get $l19)
                        (local.get $l33))))))
              (i64.const 1))
            (i64.shr_u
              (local.get $l34)
              (i64.const 63)))))
      (local.set $l40
        (i64.xor
          (i64.load
            (i32.add
              (i32.shl
                (local.get $l1)
                (i32.const 3))
              (i32.const 1024)))
          (i64.xor
            (local.tee $l39
              (i64.xor
                (local.get $l20)
                (local.get $l36)))
            (i64.and
              (i64.xor
                (local.tee $l28
                  (i64.or
                    (i64.shl
                      (local.tee $l11
                        (i64.xor
                          (local.get $l11)
                          (local.tee $l38
                            (i64.xor
                              (local.tee $l13
                                (i64.xor
                                  (local.get $l20)
                                  (i64.xor
                                    (local.get $l24)
                                    (i64.xor
                                      (local.get $l15)
                                      (i64.xor
                                        (local.get $l9)
                                        (local.get $l32))))))
                              (i64.or
                                (i64.shl
                                  (local.tee $l7
                                    (i64.xor
                                      (local.get $l37)
                                      (i64.xor
                                        (local.get $l25)
                                        (i64.xor
                                          (local.get $l8)
                                          (i64.xor
                                            (local.get $l6)
                                            (local.get $l12))))))
                                  (i64.const 1))
                                (i64.shr_u
                                  (local.get $l7)
                                  (i64.const 63)))))))
                      (i64.const 44))
                    (i64.shr_u
                      (local.get $l11)
                      (i64.const 20))))
                (i64.const -1))
              (local.tee $l8
                (i64.or
                  (i64.shl
                    (local.tee $l8
                      (i64.xor
                        (local.get $l8)
                        (local.tee $l18
                          (i64.xor
                            (i64.or
                              (i64.shl
                                (local.tee $l11
                                  (i64.xor
                                    (local.get $l22)
                                    (i64.xor
                                      (local.get $l26)
                                      (i64.xor
                                        (local.get $l16)
                                        (i64.xor
                                          (local.get $l5)
                                          (local.get $l10))))))
                                (i64.const 1))
                              (i64.shr_u
                                (local.get $l11)
                                (i64.const 63)))
                            (local.get $l34)))))
                    (i64.const 43))
                  (i64.shr_u
                    (local.get $l8)
                    (i64.const 21))))))))
      (local.set $l42
        (i64.xor
          (i64.and
            (local.tee $l41
              (i64.or
                (i64.shl
                  (local.tee $l10
                    (i64.xor
                      (local.get $l10)
                      (local.tee $l7
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l35)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l35)
                              (i64.const 63)))
                          (local.get $l7)))))
                  (i64.const 21))
                (i64.shr_u
                  (local.get $l10)
                  (i64.const 43))))
            (i64.xor
              (local.get $l8)
              (i64.const -1)))
          (local.get $l28)))
      (local.set $l44
        (i64.xor
          (i64.and
            (local.tee $l43
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l3)
                      (local.tee $l13
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l13)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l13)
                              (i64.const 63)))
                          (local.get $l11)))))
                  (i64.const 14))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 50))))
            (i64.xor
              (local.get $l41)
              (i64.const -1)))
          (local.get $l8)))
      (local.set $l46
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l14
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l13)
                        (local.get $l14)))
                    (i64.const 20))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 44))))
              (i64.const -1))
            (local.tee $l10
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l15)
                      (local.get $l36)))
                  (i64.const 3))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 61)))))
          (local.tee $l45
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l7)
                    (local.get $l22)))
                (i64.const 28))
              (i64.shr_u
                (local.get $l3)
                (i64.const 36))))))
      (local.set $l29
        (i64.xor
          (i64.and
            (local.tee $l47
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l19)
                      (local.get $l38)))
                  (i64.const 45))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 19))))
            (i64.xor
              (local.get $l10)
              (i64.const -1)))
          (local.get $l14)))
      (local.set $l48
        (i64.xor
          (i64.and
            (local.tee $l30
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l6)
                      (local.get $l18)))
                  (i64.const 61))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 3))))
            (i64.xor
              (local.get $l47)
              (i64.const -1)))
          (local.get $l10)))
      (local.set $l49
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l15
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l18)
                        (local.get $l25)))
                    (i64.const 6))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 58))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l7)
                      (local.get $l16)))
                  (i64.const 25))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 39)))))
          (local.tee $l31
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l21)
                    (local.get $l38)))
                (i64.const 1))
              (i64.shr_u
                (local.get $l3)
                (i64.const 63))))))
      (local.set $l50
        (i64.xor
          (i64.and
            (local.tee $l20
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l4)
                      (local.get $l13)))
                  (i64.const 8))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 56))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l15)))
      (local.set $l22
        (i64.xor
          (i64.and
            (local.tee $l21
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l9)
                      (local.get $l36)))
                  (i64.const 18))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 46))))
            (i64.xor
              (local.get $l20)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l51
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l10
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l24)
                        (local.get $l36)))
                    (i64.const 36))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 28))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l27)
                      (local.get $l38)))
                  (i64.const 10))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 54)))))
          (local.tee $l23
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l13)
                    (local.get $l23)))
                (i64.const 27))
              (i64.shr_u
                (local.get $l3)
                (i64.const 37))))))
      (local.set $l11
        (i64.xor
          (i64.and
            (local.tee $l24
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l12)
                      (local.get $l18)))
                  (i64.const 15))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 49))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l10)))
      (local.set $l34
        (i64.xor
          (i64.and
            (local.tee $l8
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l5)
                      (local.get $l7)))
                  (i64.const 56))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 8))))
            (i64.xor
              (local.get $l24)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l7
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l4
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l7)
                        (local.get $l26)))
                    (i64.const 55))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 9))))
              (i64.const -1))
            (local.tee $l9
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l13)
                      (local.get $l17)))
                  (i64.const 39))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 25)))))
          (local.tee $l16
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l18)
                    (local.get $l37)))
                (i64.const 62))
              (i64.shr_u
                (local.get $l3)
                (i64.const 2))))))
      (local.set $l35
        (i64.xor
          (i64.and
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l32)
                      (local.get $l36)))
                  (i64.const 41))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 23))))
            (i64.xor
              (local.get $l9)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l25
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l33)
                      (local.get $l38)))
                  (i64.const 2))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 62))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l9)))
      (local.set $l18
        (i64.xor
          (local.tee $l26
            (i64.xor
              (local.tee $l32
                (i64.xor
                  (i64.and
                    (i64.xor
                      (local.get $l23)
                      (i64.const -1))
                    (local.get $l10))
                  (local.get $l8)))
              (i64.xor
                (local.tee $l19
                  (i64.xor
                    (i64.and
                      (i64.xor
                        (local.get $l45)
                        (i64.const -1))
                      (local.get $l14))
                    (local.get $l30)))
                (i64.xor
                  (local.tee $l10
                    (i64.xor
                      (i64.and
                        (i64.xor
                          (local.get $l39)
                          (i64.const -1))
                        (local.get $l28))
                      (local.get $l43)))
                  (i64.xor
                    (local.tee $l13
                      (i64.xor
                        (i64.and
                          (i64.xor
                            (local.get $l31)
                            (i64.const -1))
                          (local.get $l15))
                        (local.get $l21)))
                    (local.tee $l12
                      (i64.xor
                        (i64.and
                          (i64.xor
                            (local.get $l16)
                            (i64.const -1))
                          (local.get $l4))
                        (local.get $l5))))))))
          (i64.or
            (i64.shl
              (local.tee $l17
                (i64.xor
                  (local.get $l35)
                  (i64.xor
                    (local.get $l50)
                    (i64.xor
                      (i64.xor
                        (local.get $l11)
                        (local.get $l42))
                      (local.get $l29)))))
              (i64.const 1))
            (i64.shr_u
              (local.get $l17)
              (i64.const 63)))))
      (local.set $l20
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l27
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.tee $l28
                          (i64.xor
                            (local.tee $l15
                              (i64.xor
                                (i64.xor
                                  (local.get $l7)
                                  (i64.xor
                                    (i64.xor
                                      (local.get $l49)
                                      (local.get $l51))
                                    (local.get $l46)))
                                (local.get $l40)))
                            (i64.or
                              (i64.shl
                                (local.tee $l14
                                  (i64.xor
                                    (local.get $l22)
                                    (i64.xor
                                      (i64.xor
                                        (local.get $l25)
                                        (i64.xor
                                          (local.get $l34)
                                          (local.get $l48)))
                                      (local.get $l44))))
                                (i64.const 1))
                              (i64.shr_u
                                (local.get $l14)
                                (i64.const 63)))))
                        (local.get $l29)))
                    (i64.const 44))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 20))))
              (i64.const -1))
            (local.tee $l16
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l22)
                      (local.tee $l29
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.tee $l8
                                (i64.xor
                                  (local.tee $l4
                                    (i64.xor
                                      (i64.and
                                        (i64.xor
                                          (local.get $l8)
                                          (i64.const -1))
                                        (local.get $l23))
                                      (local.get $l24)))
                                  (i64.xor
                                    (i64.xor
                                      (local.tee $l9
                                        (i64.xor
                                          (i64.and
                                            (i64.xor
                                              (local.get $l21)
                                              (i64.const -1))
                                            (local.get $l31))
                                          (local.get $l20)))
                                      (i64.xor
                                        (local.tee $l33
                                          (i64.xor
                                            (i64.and
                                              (i64.xor
                                                (local.get $l5)
                                                (i64.const -1))
                                              (local.get $l16))
                                            (local.get $l6)))
                                        (local.tee $l6
                                          (i64.xor
                                            (i64.and
                                              (i64.xor
                                                (local.get $l30)
                                                (i64.const -1))
                                              (local.get $l45))
                                            (local.get $l47)))))
                                    (local.tee $l5
                                      (i64.xor
                                        (i64.and
                                          (i64.xor
                                            (local.get $l43)
                                            (i64.const -1))
                                          (local.get $l39))
                                        (local.get $l41))))))
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l8)
                              (i64.const 63)))
                          (local.get $l17)))))
                  (i64.const 43))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 21)))))
          (i64.xor
            (local.tee $l17
              (i64.xor
                (local.get $l18)
                (local.get $l40)))
            (i64.load
              (i32.add
                (i32.shl
                  (i32.or
                    (local.get $l1)
                    (i32.const 1))
                  (i32.const 3))
                (i32.const 1024))))))
      (local.set $l21
        (i64.xor
          (i64.and
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l4)
                      (local.tee $l30
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l26)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l26)
                              (i64.const 63)))
                          (local.get $l14)))))
                  (i64.const 21))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 43))))
            (i64.xor
              (local.get $l16)
              (i64.const -1)))
          (local.get $l27)))
      (local.set $l37
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l12)
                      (local.tee $l31
                        (i64.xor
                          (i64.or
                            (i64.shl
                              (local.get $l15)
                              (i64.const 1))
                            (i64.shr_u
                              (local.get $l15)
                              (i64.const 63)))
                          (local.get $l8)))))
                  (i64.const 14))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 50))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l16)))
      (local.set $l22
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l17))
          (local.get $l4)))
      (local.set $l23
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l17)
              (i64.const -1))
            (local.get $l27))
          (local.get $l3)))
      (local.set $l24
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l19
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l19)
                        (local.get $l31)))
                    (i64.const 20))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 44))))
              (i64.const -1))
            (local.tee $l12
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l18)
                      (local.get $l49)))
                  (i64.const 3))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 61)))))
          (local.tee $l4
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l5)
                    (local.get $l30)))
                (i64.const 28))
              (i64.shr_u
                (local.get $l3)
                (i64.const 36))))))
      (local.set $l11
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l11)
                      (local.get $l28)))
                  (i64.const 45))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 19))))
            (i64.xor
              (local.get $l12)
              (i64.const -1)))
          (local.get $l19)))
      (local.set $l25
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l25)
                      (local.get $l29)))
                  (i64.const 61))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 3))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l12)))
      (local.set $l26
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l4))
          (local.get $l5)))
      (local.set $l14
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l4)
              (i64.const -1))
            (local.get $l19))
          (local.get $l3)))
      (local.set $l15
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l12
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l29)
                        (local.get $l48)))
                    (i64.const 6))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 58))))
              (i64.const -1))
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l9)
                      (local.get $l30)))
                  (i64.const 25))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 39)))))
          (local.tee $l9
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l28)
                    (local.get $l42)))
                (i64.const 1))
              (i64.shr_u
                (local.get $l3)
                (i64.const 63))))))
      (local.set $l27
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l31)
                      (local.get $l32)))
                  (i64.const 8))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 56))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l12)))
      (local.set $l8
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l7)
                      (local.get $l18)))
                  (i64.const 18))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 46))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l16
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l9))
          (local.get $l5)))
      (local.set $l17
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l9)
              (i64.const -1))
            (local.get $l12))
          (local.get $l3)))
      (local.set $l32
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l7
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l18)
                        (local.get $l46)))
                    (i64.const 36))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 28))))
              (i64.const -1))
            (local.tee $l4
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l28)
                      (local.get $l50)))
                  (i64.const 10))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 54)))))
          (local.tee $l9
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l10)
                    (local.get $l31)))
                (i64.const 27))
              (i64.shr_u
                (local.get $l3)
                (i64.const 37))))))
      (local.set $l19
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l29)
                      (local.get $l34)))
                  (i64.const 15))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 49))))
            (i64.xor
              (local.get $l4)
              (i64.const -1)))
          (local.get $l7)))
      (local.set $l12
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l30)
                      (local.get $l33)))
                  (i64.const 56))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 8))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l4)))
      (local.set $l10
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l9))
          (local.get $l5)))
      (local.set $l4
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l9)
              (i64.const -1))
            (local.get $l7))
          (local.get $l3)))
      (local.set $l9
        (i64.xor
          (i64.and
            (i64.xor
              (local.tee $l7
                (i64.or
                  (i64.shl
                    (local.tee $l3
                      (i64.xor
                        (local.get $l6)
                        (local.get $l30)))
                    (i64.const 55))
                  (i64.shr_u
                    (local.get $l3)
                    (i64.const 9))))
              (i64.const -1))
            (local.tee $l6
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l13)
                      (local.get $l31)))
                  (i64.const 39))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 25)))))
          (local.tee $l13
            (i64.or
              (i64.shl
                (local.tee $l3
                  (i64.xor
                    (local.get $l29)
                    (local.get $l44)))
                (i64.const 62))
              (i64.shr_u
                (local.get $l3)
                (i64.const 2))))))
      (local.set $l33
        (i64.xor
          (i64.and
            (local.tee $l5
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l18)
                      (local.get $l51)))
                  (i64.const 41))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 23))))
            (i64.xor
              (local.get $l6)
              (i64.const -1)))
          (local.get $l7)))
      (local.set $l6
        (i64.xor
          (i64.and
            (local.tee $l3
              (i64.or
                (i64.shl
                  (local.tee $l3
                    (i64.xor
                      (local.get $l28)
                      (local.get $l35)))
                  (i64.const 2))
                (i64.shr_u
                  (local.get $l3)
                  (i64.const 62))))
            (i64.xor
              (local.get $l5)
              (i64.const -1)))
          (local.get $l6)))
      (local.set $l5
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l3)
              (i64.const -1))
            (local.get $l13))
          (local.get $l5)))
      (local.set $l3
        (i64.xor
          (i64.and
            (i64.xor
              (local.get $l13)
              (i64.const -1))
            (local.get $l7))
          (local.get $l3)))
      (br_if $L0
        (i32.lt_u
          (local.tee $l1
            (i32.add
              (local.get $l1)
              (i32.const 2)))
          (i32.const 24))))
    (i64.store
      (local.get $p0)
      (local.get $l20))
    (i64.store offset=8
      (local.get $p0)
      (local.get $l21))
    (i64.store offset=16
      (local.get $p0)
      (local.get $l37))
    (i64.store offset=24
      (local.get $p0)
      (local.get $l22))
    (i64.store offset=32
      (local.get $p0)
      (local.get $l23))
    (i64.store offset=40
      (local.get $p0)
      (local.get $l24))
    (i64.store offset=48
      (local.get $p0)
      (local.get $l11))
    (i64.store offset=56
      (local.get $p0)
      (local.get $l25))
    (i64.store
      (local.get $l2)
      (local.get $l26))
    (i64.store offset=72
      (local.get $p0)
      (local.get $l14))
    (i64.store offset=80
      (local.get $p0)
      (local.get $l15))
    (i64.store offset=88
      (local.get $p0)
      (local.get $l27))
    (i64.store offset=96
      (local.get $p0)
      (local.get $l8))
    (i64.store offset=104
      (local.get $p0)
      (local.get $l16))
    (i64.store offset=112
      (local.get $p0)
      (local.get $l17))
    (i64.store offset=120
      (local.get $p0)
      (local.get $l32))
    (i64.store offset=128
      (local.get $p0)
      (local.get $l19))
    (i64.store offset=136
      (local.get $p0)
      (local.get $l12))
    (i64.store offset=144
      (local.get $p0)
      (local.get $l10))
    (i64.store offset=152
      (local.get $p0)
      (local.get $l4))
    (i64.store offset=160
      (local.get $p0)
      (local.get $l9))
    (i64.store offset=168
      (local.get $p0)
      (local.get $l33))
    (i64.store offset=176
      (local.get $p0)
      (local.get $l6))
    (i64.store offset=184
      (local.get $p0)
      (local.get $l5))
    (i64.store offset=192
      (local.get $p0)
      (local.get $l3)))

  ;; https://github.com/chfast/ethash/blob/master/lib/keccak/keccak.c#L97
  ;; union ethash_hash256 ethash_keccak256(const uint8_t* data, size_t size)
  ;; {
  ;;     union ethash_hash256 hash;
  ;;     // keccak() here is always inlined
  ;;     keccak(hash.word64s, 256, data, size);
  ;;     return hash;
  ;; }
  ;;
  ;; static INLINE ALWAYS_INLINE void keccak(
  ;;   uint64_t* out, size_t bits, const uint8_t* data, size_t size)
  ;; {


;;(func $watimports.$ethash_keccak256 (param $p0 i32) (param $p1 i32) (param $p2 i32)
(func $keccak/ethash_keccak256 (param $p0 i32) (param $p1 i32) (param $p2 i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32) (local $l9 i32) (local $l10 i32) (local $l11 i32) (local $l12 i64) (local $l13 i64) (local $l14 i64) (local $l15 i64) (local $l16 i64) (local $l17 i64) (local $l18 i64) (local $l19 i64) (local $l20 i64) (local $l21 i64) (local $l22 i64) (local $l23 i64) (local $l24 i64) (local $l25 i64)
    (local.set $l8
      (global.get $g0_ethash_keccak))
    (global.set $g0_ethash_keccak
      (i32.add
        (global.get $g0_ethash_keccak)
        (i32.const 208)))
    (i64.store
      (local.tee $l7
        (i32.add
          (local.get $l8)
          (i32.const 200)))
      (i64.const 0))
    (drop
      (call $f2_ethash_keccak
        (local.tee $l3
          (local.get $l8))
        (i32.const 0)
        (i32.const 200)))

    ;; while (size >= block_size)
    (if $I0
      (i32.ge_u
        (local.get $p2)
        (i32.const 136))
      (then
        (local.set $l4
          (i32.sub
            (local.get $l3)
            (i32.const -64)))

        (loop $L1
          (i64.store
            (local.get $l3)
            (i64.xor
              (local.get $l12)
              (i64.load align=1
                (local.get $p1))))
          (i64.store offset=8
            (local.get $l3)
            (i64.xor
              (local.get $l13)
              (i64.load offset=8 align=1
                (local.get $p1))))
          (i64.store offset=16
            (local.get $l3)
            (i64.xor
              (local.get $l18)
              (i64.load offset=16 align=1
                (local.get $p1))))
          (i64.store offset=24
            (local.get $l3)
            (i64.xor
              (local.get $l19)
              (i64.load offset=24 align=1
                (local.get $p1))))
          (i64.store offset=32
            (local.get $l3)
            (i64.xor
              (local.get $l20)
              (i64.load offset=32 align=1
                (local.get $p1))))
          (i64.store offset=40
            (local.get $l3)
            (i64.xor
              (local.get $l21)
              (i64.load offset=40 align=1
                (local.get $p1))))
          (i64.store offset=48
            (local.get $l3)
            (i64.xor
              (local.get $l22)
              (i64.load offset=48 align=1
                (local.get $p1))))
          (i64.store offset=56
            (local.get $l3)
            (i64.xor
              (local.get $l23)
              (i64.load offset=56 align=1
                (local.get $p1))))
          (i64.store
            (local.get $l4)
            (i64.xor
              (local.get $l24)
              (i64.load align=1
                (i32.sub
                  (local.get $p1)
                  (i32.const -64)))))
          (i64.store offset=72
            (local.get $l3)
            (i64.xor
              (local.get $l25)
              (i64.load offset=72 align=1
                (local.get $p1))))
          (i64.store offset=80
            (local.get $l3)
            (i64.xor
              (local.get $l14)
              (i64.load offset=80 align=1
                (local.get $p1))))
          (i64.store offset=88
            (local.get $l3)
            (i64.xor
              (local.get $l15)
              (i64.load offset=88 align=1
                (local.get $p1))))
          (i64.store offset=96
            (local.get $l3)
            (i64.xor
              (local.get $l16)
              (i64.load offset=96 align=1
                (local.get $p1))))
          (i64.store offset=104
            (local.get $l3)
            (i64.xor
              (local.get $l17)
              (i64.load offset=104 align=1
                (local.get $p1))))
          (i64.store offset=112
            (local.get $l3)
            (i64.xor
              (i64.load offset=112
                (local.get $l3))
              (i64.load offset=112 align=1
                (local.get $p1))))
          (i64.store offset=120
            (local.get $l3)
            (i64.xor
              (i64.load offset=120
                (local.get $l3))
              (i64.load offset=120 align=1
                (local.get $p1))))
          (i64.store offset=128
            (local.get $l3)
            (i64.xor
              (i64.load offset=128
                (local.get $l3))
              (i64.load offset=128 align=1
                (local.get $p1))))
          (local.set $p1
            (i32.add
              (local.get $p1)
              (i32.const 136)))


          ;; 136 == const size_t block_size = (1600 - bits * 2) / 8;
          ;; ethash_keccakf1600
          (call $ethash_keccakf1600
            (local.get $l3))
          (if $I2
            (i32.ge_u
              (local.tee $p2
                (i32.add
                  (local.get $p2)
                  (i32.const -136)))
              (i32.const 136))
            (then
              (local.set $l12
                (i64.load
                  (local.get $l3)))
              (local.set $l13
                (i64.load offset=8
                  (local.get $l3)))
              (local.set $l14
                (i64.load offset=80
                  (local.get $l3)))
              (local.set $l15
                (i64.load offset=88
                  (local.get $l3)))
              (local.set $l16
                (i64.load offset=96
                  (local.get $l3)))
              (local.set $l17
                (i64.load offset=104
                  (local.get $l3)))
              (local.set $l18
                (i64.load offset=16
                  (local.get $l3)))
              (local.set $l19
                (i64.load offset=24
                  (local.get $l3)))
              (local.set $l20
                (i64.load offset=32
                  (local.get $l3)))
              (local.set $l21
                (i64.load offset=40
                  (local.get $l3)))
              (local.set $l22
                (i64.load offset=48
                  (local.get $l3)))
              (local.set $l23
                (i64.load offset=56
                  (local.get $l3)))
              (local.set $l24
                (i64.load
                  (local.get $l4)))
              (local.set $l25
                (i64.load offset=72
                  (local.get $l3)))
              (br $L1))))))

    ;; while (size >= word_size) ??

    (local.set $l5
      (if $I3 (result i32)
        (i32.gt_u
          (local.get $p2)
          (i32.const 7))
        (then
          (i32.add
            (i32.shl
              (i32.add
                (block $B4 (result i32)
                  (local.set $l11
                    (i32.shr_u
                      (local.tee $l5
                        (i32.add
                          (local.get $p2)
                          (i32.const -8)))
                      (i32.const 3)))
                  (local.set $l9
                    (i32.and
                      (local.get $l5)
                      (i32.const -8)))
                  (local.set $l4
                    (local.get $p1))
                  (local.set $l6
                    (local.get $p2))
                  (local.set $p2
                    (local.get $l3))
                  (loop $L5
                    (i64.store
                      (local.get $p2)
                      (i64.xor
                        (i64.load
                          (local.get $p2))
                        (i64.load align=1
                          (local.get $l4))))
                    (local.set $p2
                      (i32.add
                        (local.get $p2)
                        (i32.const 8)))
                    (local.set $l4
                      (i32.add
                        (local.get $l4)
                        (i32.const 8)))
                    (br_if $L5
                      (i32.gt_u
                        (local.tee $l6
                          (i32.add
                            (local.get $l6)
                            (i32.const -8)))
                        (i32.const 7))))
                  (local.set $p1
                    (i32.add
                      (i32.add
                        (local.get $l9)
                        (i32.const 8))
                      (local.get $p1)))
                  (local.set $l6
                    (i32.sub
                      (local.get $l5)
                      (local.get $l9)))
                  (local.get $l11))
                (i32.const 1))
              (i32.const 3))
            (local.get $l3)))
        (else
          (local.set $l6
            (local.get $p2))
          (local.get $l3))))


    ;; while (size >= block_size) ??
    ;; loop merged with while (size >= word_size) ??

    (if $I6
      (i32.eqz
        (local.get $l6))
      (then
        (i32.store8
          (local.get $l7)
          (i32.const 1))
        (i64.store
          (local.get $l5)
          (i64.xor
            (i64.load
              (local.get $l7))
            (i64.load
              (local.get $l5))))
        (i64.store offset=128
          (local.get $l3)
          (i64.xor
            (i64.load offset=128
              (local.get $l3))
            (i64.const -9223372036854775808)))
 
        ;; ethash_keccakf1600 
        (call $ethash_keccakf1600
          (local.get $l3))

        ;; to_le64(state[i])
        (i64.store
          (local.get $p0)
          (i64.load
            (local.get $l3)))
        (i64.store offset=8
          (local.get $p0)
          (i64.load offset=8
            (local.get $l3)))
        (i64.store offset=16
          (local.get $p0)
          (i64.load offset=16
            (local.get $l3)))
        (i64.store offset=24
          (local.get $p0)
          (i64.load offset=24
            (local.get $l3)))
        (global.set $g0_ethash_keccak
          (local.get $l8))
        (return)))


    (local.set $p2
      (local.get $l7))
    (local.set $l4
      (local.get $l6))

    ;;  while (size > 0)
    (loop $L7
      (i32.store8
        (local.get $p2)
        (i32.load8_s
          (local.get $p1)))
      (local.set $p2
        (i32.add
          (local.get $p2)
          (i32.const 1)))
      (local.set $p1
        (i32.add
          (local.get $p1)
          (i32.const 1)))
      (br_if $L7
        (local.tee $l4
          (i32.add
            (local.get $l4)
            (i32.const -1)))))

    ;; *last_word_iter = 0x01;
    (i32.store8
      (i32.add
        (local.get $l6)
        (local.get $l7))
      (i32.const 1))

    ;; *state_iter ^= to_le64(last_word);
    (i64.store
      (local.get $l5)
      (i64.xor
        (i64.load
          (local.get $l7))
        (i64.load
          (local.get $l5))))

    ;; state[(block_size / word_size) - 1] ^= 0x8000000000000000;
    (i64.store offset=128
      (local.get $l3)
      (i64.xor
        (i64.load offset=128
          (local.get $l3))
        (i64.const -9223372036854775808)))

    ;; ethash_keccakf1600
    (call $ethash_keccakf1600
      (local.get $l3))

    ;; for (i = 0; i < (hash_size / word_size); ++i)
    ;;    out[i] = to_le64(state[i]);
    (i64.store
      (local.get $p0)
      (i64.load
        (local.get $l3)))
    (i64.store offset=8
      (local.get $p0)
      (i64.load offset=8
        (local.get $l3)))
    (i64.store offset=16
      (local.get $p0)
      (i64.load offset=16
        (local.get $l3)))
    (i64.store offset=24
      (local.get $p0)
      (i64.load offset=24
        (local.get $l3)))
    (global.set $g0_ethash_keccak
      (local.get $l8)))


  ;; not sure what $f2 does
  (func $f2_ethash_keccak (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32)
    (local.set $l4
      (i32.add
        (local.get $p0)
        (local.get $p2)))
    (local.set $l3
      (i32.and
        (local.get $p1)
        (i32.const 255)))
    (if $I0
      (i32.ge_s
        (local.get $p2)
        (i32.const 67))
      (then
        (loop $L1
          (if $I2
            (i32.and
              (local.get $p0)
              (i32.const 3))
            (then
              (i32.store8
                (local.get $p0)
                (local.get $l3))
              (local.set $p0
                (i32.add
                  (local.get $p0)
                  (i32.const 1)))
              (br $L1))))
        (local.set $p1
          (i32.or
            (i32.or
              (i32.or
                (i32.shl
                  (local.get $l3)
                  (i32.const 8))
                (local.get $l3))
              (i32.shl
                (local.get $l3)
                (i32.const 16)))
            (i32.shl
              (local.get $l3)
              (i32.const 24))))
        (local.set $l6
          (i32.add
            (local.tee $l5
              (i32.and
                (local.get $l4)
                (i32.const -4)))
            (i32.const -64)))
        (loop $L3
          (if $I4
            (i32.le_s
              (local.get $p0)
              (local.get $l6))
            (then
              (i32.store
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=4
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=8
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=12
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=16
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=20
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=24
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=28
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=32
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=36
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=40
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=44
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=48
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=52
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=56
                (local.get $p0)
                (local.get $p1))
              (i32.store offset=60
                (local.get $p0)
                (local.get $p1))
              (local.set $p0
                (i32.sub
                  (local.get $p0)
                  (i32.const -64)))
              (br $L3))))
        (loop $L5
          (if $I6
            (i32.lt_s
              (local.get $p0)
              (local.get $l5))
            (then
              (i32.store
                (local.get $p0)
                (local.get $p1))
              (local.set $p0
                (i32.add
                  (local.get $p0)
                  (i32.const 4)))
              (br $L5))))))
    (loop $L7
      (if $I8
        (i32.lt_s
          (local.get $p0)
          (local.get $l4))
        (then
          (i32.store8
            (local.get $p0)
            (local.get $l3))
          (local.set $p0
            (i32.add
              (local.get $p0)
              (i32.const 1)))
          (br $L7))))
    (i32.sub
      (local.get $l4)
      (local.get $p2)))

  ;; (func $main (export "main")
  ;;   (local $l0 i64)
  ;;   (local.set $l0
  ;;     (i64.const 200))
  ;;   (block $B0
  ;;     (loop $L1
  ;;       (i64.store
  ;;         (i32.const 0)
  ;;         (local.get $l0))
  ;;       (call $_ethash_keccak256
  ;;         (i32.const 16384)
  ;;         (i32.const 0)
  ;;         (i32.const 266))
  ;;       (br_if $B0
  ;;         (i64.eqz
  ;;           (local.tee $l0
  ;;             (i64.sub
  ;;               (local.get $l0)
  ;;               (i64.const 1)))))
  ;;       (br $L1))))


  ;; (func $main (export "main")
  ;;   (call $ethash_keccak256
  ;;     (i32.const 16384) ;; output offset 1024 * 16
  ;;     (i32.const 0)    ;; mem offset in
  ;;     (i32.const 266)  ;; input length
  ;;   )
  ;;   (return 0)
  ;; )

  (global $g0_ethash_keccak (mut i32) (i32.const 2960))
  (data $d0_ethash_keccak (i32.const 1024) "\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8a\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8b\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8a\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0a\00\00\80\00\00\00\00\8b\80\00\80\00\00\00\00\8b\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0a\80\00\00\00\00\00\00\0a\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80")
)
