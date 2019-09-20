(module
  (type (;0;) (func (param i32)))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (result i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (type (;5;) (func (param i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32) (result i32)))
  (type (;7;) (func (param i32 i32) (result i64)))
  (type (;8;) (func))
  (import "env" "debug_log" (func (;0;) (type 0)))
  (import "env" "debug_mem" (func (;1;) (type 1)))
  (import "env" "eth2_blockDataSize" (func (;2;) (type 2)))
  (import "env" "eth2_blockDataCopy" (func (;3;) (type 3)))
  (import "env" "eth2_loadPreStateRoot" (func (;4;) (type 0)))
  (import "env" "eth2_savePostStateRoot" (func (;5;) (type 0)))
  (import "watimports" "$ethash_keccak256" (func (;6;) (type 3)))
  (func (;7;) (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.const 1073741808
    i32.gt_u
    if  ;; label = @1
      unreachable
    end
    global.get 1
    i32.const 16
    i32.add
    local.tee 3
    local.get 0
    i32.const 1
    local.get 0
    i32.const 1
    i32.gt_u
    select
    i32.add
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    local.tee 2
    memory.size
    local.tee 4
    i32.const 16
    i32.shl
    i32.gt_u
    if  ;; label = @1
      local.get 4
      local.get 2
      local.get 3
      i32.sub
      i32.const 65535
      i32.add
      i32.const -65536
      i32.and
      i32.const 16
      i32.shr_u
      local.tee 5
      local.get 4
      local.get 5
      i32.gt_s
      select
      memory.grow
      i32.const 0
      i32.lt_s
      if  ;; label = @2
        local.get 5
        memory.grow
        i32.const 0
        i32.lt_s
        if  ;; label = @3
          unreachable
        end
      end
    end
    local.get 2
    global.set 1
    local.get 3
    i32.const 16
    i32.sub
    local.tee 2
    local.get 1
    i32.store offset=8
    local.get 2
    local.get 0
    i32.store offset=12
    local.get 3)
  (func (;8;) (type 3) (param i32 i32 i32)
    (local i32 i64)
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8
      local.get 0
      local.get 2
      i32.add
      i32.const 1
      i32.sub
      local.get 1
      i32.store8
      local.get 2
      i32.const 2
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 1
      i32.add
      local.get 1
      i32.store8
      local.get 0
      i32.const 2
      i32.add
      local.get 1
      i32.store8
      local.get 0
      local.get 2
      i32.add
      local.tee 3
      i32.const 2
      i32.sub
      local.get 1
      i32.store8
      local.get 3
      i32.const 3
      i32.sub
      local.get 1
      i32.store8
      local.get 2
      i32.const 6
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 3
      i32.add
      local.get 1
      i32.store8
      local.get 0
      local.get 2
      i32.add
      i32.const 4
      i32.sub
      local.get 1
      i32.store8
      local.get 2
      i32.const 8
      i32.le_u
      br_if 0 (;@1;)
      local.get 2
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 2
      i32.sub
      local.set 3
      local.get 0
      local.get 2
      i32.add
      local.tee 2
      local.get 1
      i32.const 255
      i32.and
      i32.const 16843009
      i32.mul
      local.tee 0
      i32.store
      local.get 3
      i32.const -4
      i32.and
      local.tee 3
      local.get 2
      i32.add
      i32.const 4
      i32.sub
      local.get 0
      i32.store
      local.get 3
      i32.const 8
      i32.le_u
      br_if 0 (;@1;)
      local.get 2
      i32.const 4
      i32.add
      local.get 0
      i32.store
      local.get 2
      i32.const 8
      i32.add
      local.get 0
      i32.store
      local.get 2
      local.get 3
      i32.add
      local.tee 1
      i32.const 12
      i32.sub
      local.get 0
      i32.store
      local.get 1
      i32.const 8
      i32.sub
      local.get 0
      i32.store
      local.get 3
      i32.const 24
      i32.le_u
      br_if 0 (;@1;)
      local.get 2
      i32.const 12
      i32.add
      local.get 0
      i32.store
      local.get 2
      i32.const 16
      i32.add
      local.get 0
      i32.store
      local.get 2
      i32.const 20
      i32.add
      local.get 0
      i32.store
      local.get 2
      i32.const 24
      i32.add
      local.get 0
      i32.store
      local.get 2
      local.get 3
      i32.add
      local.tee 1
      i32.const 28
      i32.sub
      local.get 0
      i32.store
      local.get 1
      i32.const 24
      i32.sub
      local.get 0
      i32.store
      local.get 1
      i32.const 20
      i32.sub
      local.get 0
      i32.store
      local.get 1
      i32.const 16
      i32.sub
      local.get 0
      i32.store
      local.get 2
      local.get 2
      i32.const 4
      i32.and
      i32.const 24
      i32.add
      local.tee 2
      i32.add
      local.set 1
      local.get 3
      local.get 2
      i32.sub
      local.set 2
      local.get 0
      i64.extend_i32_u
      local.get 0
      i64.extend_i32_u
      i64.const 32
      i64.shl
      i64.or
      local.set 4
      loop  ;; label = @2
        local.get 2
        i32.const 32
        i32.lt_u
        i32.eqz
        if  ;; label = @3
          local.get 1
          local.get 4
          i64.store
          local.get 1
          i32.const 8
          i32.add
          local.get 4
          i64.store
          local.get 1
          i32.const 16
          i32.add
          local.get 4
          i64.store
          local.get 1
          i32.const 24
          i32.add
          local.get 4
          i64.store
          local.get 2
          i32.const 32
          i32.sub
          local.set 2
          local.get 1
          i32.const 32
          i32.add
          local.set 1
          br 1 (;@2;)
        end
      end
    end)
  (func (;9;) (type 5) (param i32) (result i32)
    (local i32)
    local.get 0
    i32.const 1073741808
    i32.gt_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.const 0
    call 7
    local.tee 1
    i32.const 0
    local.get 0
    call 8
    local.get 1)
  (func (;10;) (type 5) (param i32) (result i32)
    local.get 0
    i32.const 16
    i32.sub
    i32.load offset=12)
  (func (;11;) (type 5) (param i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      i32.const 0
      local.get 0
      call 10
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 32
      local.get 0
      call 10
      i32.gt_s
      br_if 0 (;@1;)
      i32.const 12
      i32.const 3
      call 7
      local.tee 1
      local.set 2
      local.get 1
      i32.load
      drop
      local.get 2
      local.get 0
      i32.store
      local.get 1
      i32.const 32
      i32.store offset=8
      local.get 1
      local.get 0
      i32.store offset=4
      local.get 1
      return
    end
    unreachable)
  (func (;12;) (type 4) (param i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      i32.const 0
      local.get 0
      call 10
      i32.ge_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 0
      i32.lt_s
      if  ;; label = @2
        local.get 1
        i32.const -1
        i32.ne
        br_if 1 (;@1;)
        local.get 0
        call 10
        i32.const -2147483648
        i32.and
        br_if 1 (;@1;)
        local.get 0
        call 10
        local.set 1
      end
      local.get 1
      local.get 0
      call 10
      i32.gt_s
      br_if 0 (;@1;)
      i32.const 12
      i32.const 4
      call 7
      local.tee 2
      local.set 3
      local.get 2
      i32.load
      drop
      local.get 3
      local.get 0
      i32.store
      local.get 2
      local.get 1
      i32.store offset=8
      local.get 2
      local.get 0
      i32.store offset=4
      local.get 2
      return
    end
    unreachable)
  (func (;13;) (type 4) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load offset=8
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.add
    i32.load8_u)
  (func (;14;) (type 4) (param i32 i32) (result i32)
    (local i32)
    i32.const 8
    i32.const 7
    call 7
    local.tee 2
    i32.const 0
    i32.store
    local.get 2
    i32.const 0
    i32.store offset=4
    local.get 2
    i32.load
    drop
    local.get 2
    local.get 0
    i32.store
    local.get 2
    i32.load offset=4
    drop
    local.get 2
    local.get 1
    i32.store offset=4
    local.get 2)
  (func (;15;) (type 6) (param i32 i32 i32) (result i32)
    local.get 1
    i32.const 1073741808
    local.get 2
    i32.shr_u
    i32.gt_u
    if  ;; label = @1
      unreachable
    end
    local.get 1
    local.get 2
    i32.shl
    local.tee 2
    i32.const 0
    call 7
    local.tee 1
    i32.const 0
    local.get 2
    call 8
    local.get 0
    i32.eqz
    if  ;; label = @1
      i32.const 12
      i32.const 2
      call 7
      local.set 0
    end
    local.get 0
    i32.const 0
    i32.store
    local.get 0
    i32.const 0
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    i32.load
    drop
    local.get 0
    local.get 1
    i32.store
    local.get 0
    local.get 1
    i32.store offset=4
    local.get 0
    local.get 2
    i32.store offset=8
    local.get 0)
  (func (;16;) (type 5) (param i32) (result i32)
    i32.const 12
    i32.const 4
    call 7
    local.get 0
    i32.const 0
    call 15)
  (func (;17;) (type 4) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    if  ;; label = @1
      i32.const 8
      i32.const 5
      call 7
      local.tee 2
      i32.const 0
      i32.store
      local.get 2
      i32.const 0
      i32.store offset=4
    else
      i32.const 8
      i32.const 5
      call 7
      local.tee 2
      i32.const 0
      i32.store
      local.get 2
      i32.const 0
      i32.store offset=4
      i32.const 0
      call 16
      local.set 0
    end
    local.get 2
    i32.load
    drop
    local.get 2
    local.get 0
    i32.store
    local.get 1
    if  ;; label = @1
      local.get 2
      i32.load offset=4
      drop
      local.get 2
      local.get 1
      i32.store offset=4
    else
      i32.const 16
      i32.const 6
      call 7
      i32.const 0
      i32.const 2
      call 15
      local.tee 0
      i32.const 0
      i32.store offset=12
      local.get 0
      i32.const 0
      i32.store offset=12
      local.get 2
      i32.load offset=4
      drop
      local.get 2
      local.get 0
      i32.store offset=4
    end
    local.get 2)
  (func (;18;) (type 6) (param i32 i32 i32) (result i32)
    (local i32 i32)
    local.get 0
    local.tee 4
    i32.load offset=8
    local.set 3
    local.get 1
    i32.const 0
    i32.lt_s
    if (result i32)  ;; label = @1
      local.get 1
      local.get 3
      i32.add
      local.tee 0
      i32.const 0
      local.get 0
      i32.const 0
      i32.gt_s
      select
    else
      local.get 1
      local.get 3
      local.get 1
      local.get 3
      i32.lt_s
      select
    end
    local.set 0
    local.get 2
    i32.const 0
    i32.lt_s
    if (result i32)  ;; label = @1
      local.get 2
      local.get 3
      i32.add
      local.tee 1
      i32.const 0
      local.get 1
      i32.const 0
      i32.gt_s
      select
    else
      local.get 2
      local.get 3
      local.get 2
      local.get 3
      i32.lt_s
      select
    end
    local.set 2
    i32.const 12
    i32.const 4
    call 7
    local.set 1
    local.get 4
    i32.load
    local.tee 3
    local.get 1
    i32.load
    i32.ne
    drop
    local.get 1
    local.get 3
    i32.store
    local.get 1
    local.get 4
    i32.load offset=4
    local.get 0
    i32.add
    i32.store offset=4
    local.get 1
    local.get 2
    local.get 0
    local.get 2
    local.get 0
    i32.gt_s
    select
    local.get 0
    i32.sub
    i32.store offset=8
    local.get 1)
  (func (;19;) (type 5) (param i32) (result i32)
    local.get 0
    i32.const 16
    i32.sub
    i32.load offset=12
    i32.const 1
    i32.shr_u)
  (func (;20;) (type 5) (param i32) (result i32)
    (local i32)
    local.get 0
    i32.const 10016
    call 19
    i32.ge_u
    if  ;; label = @1
      i32.const 10064
      return
    end
    i32.const 2
    i32.const 1
    call 7
    local.tee 1
    local.get 0
    i32.const 1
    i32.shl
    i32.const 10016
    i32.add
    i32.load16_u
    i32.store16
    local.get 1)
  (func (;21;) (type 3) (param i32 i32 i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 2
      local.set 3
      local.get 0
      local.get 1
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.lt_u
      if  ;; label = @2
        local.get 1
        i32.const 7
        i32.and
        local.get 0
        i32.const 7
        i32.and
        i32.eq
        if  ;; label = @3
          loop  ;; label = @4
            local.get 0
            i32.const 7
            i32.and
            if  ;; label = @5
              local.get 3
              i32.eqz
              br_if 4 (;@1;)
              local.get 3
              i32.const 1
              i32.sub
              local.set 3
              local.get 0
              local.tee 2
              i32.const 1
              i32.add
              local.set 0
              local.get 1
              local.tee 4
              i32.const 1
              i32.add
              local.set 1
              local.get 2
              local.get 4
              i32.load8_u
              i32.store8
              br 1 (;@4;)
            end
          end
          loop  ;; label = @4
            local.get 3
            i32.const 8
            i32.lt_u
            i32.eqz
            if  ;; label = @5
              local.get 0
              local.get 1
              i64.load
              i64.store
              local.get 3
              i32.const 8
              i32.sub
              local.set 3
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 1
              i32.const 8
              i32.add
              local.set 1
              br 1 (;@4;)
            end
          end
        end
        loop  ;; label = @3
          local.get 3
          if  ;; label = @4
            local.get 0
            local.tee 2
            i32.const 1
            i32.add
            local.set 0
            local.get 1
            local.tee 4
            i32.const 1
            i32.add
            local.set 1
            local.get 2
            local.get 4
            i32.load8_u
            i32.store8
            local.get 3
            i32.const 1
            i32.sub
            local.set 3
            br 1 (;@3;)
          end
        end
      else
        local.get 1
        i32.const 7
        i32.and
        local.get 0
        i32.const 7
        i32.and
        i32.eq
        if  ;; label = @3
          loop  ;; label = @4
            local.get 0
            local.get 3
            i32.add
            i32.const 7
            i32.and
            if  ;; label = @5
              local.get 3
              i32.eqz
              br_if 4 (;@1;)
              local.get 0
              local.get 3
              i32.const 1
              i32.sub
              local.tee 3
              i32.add
              local.get 1
              local.get 3
              i32.add
              i32.load8_u
              i32.store8
              br 1 (;@4;)
            end
          end
          loop  ;; label = @4
            local.get 3
            i32.const 8
            i32.lt_u
            i32.eqz
            if  ;; label = @5
              local.get 0
              local.get 3
              i32.const 8
              i32.sub
              local.tee 3
              i32.add
              local.get 1
              local.get 3
              i32.add
              i64.load
              i64.store
              br 1 (;@4;)
            end
          end
        end
        loop  ;; label = @3
          local.get 3
          if  ;; label = @4
            local.get 0
            local.get 3
            i32.const 1
            i32.sub
            local.tee 3
            i32.add
            local.get 1
            local.get 3
            i32.add
            i32.load8_u
            i32.store8
            br 1 (;@3;)
          end
        end
      end
    end)
  (func (;22;) (type 4) (param i32 i32) (result i32)
    (local i32 i32)
    local.get 1
    local.get 0
    i32.const 16
    i32.sub
    local.tee 2
    i32.load offset=12
    local.tee 3
    i32.gt_u
    if  ;; label = @1
      local.get 1
      local.get 2
      i32.load offset=8
      call 7
      local.tee 1
      local.get 0
      local.get 3
      call 21
      local.get 1
      local.set 0
    else
      local.get 2
      local.get 1
      i32.store offset=12
    end
    local.get 0)
  (func (;23;) (type 3) (param i32 i32 i32)
    (local i32 i32)
    local.get 1
    local.get 0
    i32.load offset=8
    local.tee 3
    local.get 2
    i32.shr_u
    i32.gt_u
    if  ;; label = @1
      local.get 1
      i32.const 1073741808
      local.get 2
      i32.shr_u
      i32.gt_u
      if  ;; label = @2
        unreachable
      end
      local.get 0
      i32.load
      local.tee 4
      local.get 1
      local.get 2
      i32.shl
      local.tee 2
      call 22
      local.tee 1
      local.get 3
      i32.add
      i32.const 0
      local.get 2
      local.get 3
      i32.sub
      call 8
      local.get 1
      local.get 4
      i32.ne
      if  ;; label = @2
        local.get 0
        local.get 1
        i32.store
        local.get 0
        local.get 1
        i32.store offset=4
      end
      local.get 0
      local.get 2
      i32.store offset=8
    end)
  (func (;24;) (type 1) (param i32 i32)
    (local i32 i32)
    local.get 0
    local.get 0
    i32.load offset=12
    local.tee 2
    i32.const 1
    i32.add
    local.tee 3
    i32.const 2
    call 23
    local.get 0
    i32.load offset=4
    local.get 2
    i32.const 2
    i32.shl
    i32.add
    local.get 1
    i32.store
    local.get 0
    local.get 3
    i32.store offset=12)
  (func (;25;) (type 5) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    i32.load offset=12
    local.tee 1
    if  ;; label = @1
      local.get 0
      i32.load offset=4
      local.set 2
      local.get 0
      i32.load offset=4
      local.get 1
      i32.const 1
      i32.sub
      i32.const 2
      i32.shl
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 2
        local.get 1
        i32.lt_u
        if  ;; label = @3
          local.get 2
          i32.load
          local.set 3
          local.get 2
          local.get 1
          i32.load
          i32.store
          local.get 1
          local.get 3
          i32.store
          local.get 2
          i32.const 4
          i32.add
          local.set 2
          local.get 1
          i32.const 4
          i32.sub
          local.set 1
          br 1 (;@2;)
        end
      end
    end
    local.get 0)
  (func (;26;) (type 5) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.sub
    local.tee 4
    i32.const 0
    i32.lt_s
    if  ;; label = @1
      i32.const 10064
      return
    end
    local.get 0
    i32.load offset=4
    local.set 5
    local.get 4
    i32.eqz
    if  ;; label = @1
      local.get 5
      i32.load
      return
    end
    i32.const 10064
    call 19
    local.set 6
    i32.const 0
    local.set 0
    local.get 4
    i32.const 1
    i32.add
    local.set 3
    loop  ;; label = @1
      local.get 1
      local.get 3
      i32.lt_s
      if  ;; label = @2
        local.get 1
        i32.const 2
        i32.shl
        local.get 5
        i32.add
        i32.load
        local.set 0
        local.get 0
        if  ;; label = @3
          local.get 0
          call 19
          local.get 2
          i32.add
          local.set 2
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        br 1 (;@1;)
      end
    end
    i32.const 0
    local.set 1
    local.get 4
    local.get 6
    i32.mul
    local.get 2
    i32.add
    i32.const 1
    i32.shl
    i32.const 1
    call 7
    local.set 2
    i32.const 0
    local.set 3
    loop  ;; label = @1
      local.get 3
      local.get 4
      i32.lt_s
      if  ;; label = @2
        local.get 3
        i32.const 2
        i32.shl
        local.get 5
        i32.add
        i32.load
        local.set 0
        local.get 0
        if  ;; label = @3
          local.get 1
          i32.const 1
          i32.shl
          local.get 2
          i32.add
          local.get 0
          local.get 0
          call 19
          local.tee 7
          i32.const 1
          i32.shl
          call 21
          local.get 1
          local.get 7
          i32.add
          local.set 1
        end
        local.get 6
        if  ;; label = @3
          local.get 1
          i32.const 1
          i32.shl
          local.get 2
          i32.add
          i32.const 10064
          local.get 6
          i32.const 1
          i32.shl
          call 21
          local.get 1
          local.get 6
          i32.add
          local.set 1
        end
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        br 1 (;@1;)
      end
    end
    local.get 4
    i32.const 2
    i32.shl
    local.get 5
    i32.add
    i32.load
    local.set 0
    local.get 0
    if  ;; label = @1
      local.get 1
      i32.const 1
      i32.shl
      local.get 2
      i32.add
      local.get 0
      local.get 0
      call 19
      i32.const 1
      i32.shl
      call 21
    end
    local.get 2)
  (func (;27;) (type 5) (param i32) (result i32)
    (local i32 i32 i32)
    i32.const 10080
    call 19
    i32.const 1
    i32.shl
    local.set 2
    local.get 2
    local.get 0
    i32.const 10104
    local.get 0
    select
    local.tee 0
    call 19
    i32.const 1
    i32.shl
    local.tee 3
    i32.add
    local.tee 1
    i32.eqz
    if  ;; label = @1
      i32.const 10064
      return
    end
    local.get 1
    i32.const 1
    call 7
    local.tee 1
    i32.const 10080
    local.get 2
    call 21
    local.get 1
    local.get 2
    i32.add
    local.get 0
    local.get 3
    call 21
    local.get 1)
  (func (;28;) (type 5) (param i32) (result i32)
    (local i32 i32)
    i32.const 16
    i32.const 8
    call 7
    i32.const 0
    i32.const 2
    call 15
    local.tee 1
    i32.const 0
    i32.store offset=12
    local.get 1
    i32.const 0
    i32.store offset=12
    loop  ;; label = @1
      local.get 0
      i32.const 15
      i32.and
      local.set 2
      local.get 0
      i32.const 16
      i32.div_u
      local.set 0
      local.get 1
      local.get 2
      call 20
      call 24
      local.get 0
      br_if 0 (;@1;)
    end
    local.get 1
    call 25
    call 26
    local.tee 0
    call 19
    i32.const 2
    i32.rem_s
    if (result i32)  ;; label = @1
      local.get 0
      call 27
    else
      local.get 0
    end)
  (func (;29;) (type 4) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    call 19
    i32.ge_u
    if  ;; label = @1
      i32.const -1
      return
    end
    local.get 1
    i32.const 1
    i32.shl
    local.get 0
    i32.add
    i32.load16_u)
  (func (;30;) (type 3) (param i32 i32 i32)
    local.get 1
    local.get 0
    i32.load offset=8
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.add
    local.get 2
    i32.store8)
  (func (;31;) (type 5) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load
    i32.sub)
  (func (;32;) (type 4) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 1
    i32.add
    local.tee 4
    local.get 0
    i32.lt_u
    if  ;; label = @1
      unreachable
    end
    local.get 1
    i32.const 1
    i32.shl
    i32.const 1
    call 7
    local.tee 5
    local.set 2
    loop  ;; label = @1
      block  ;; label = @2
        local.get 0
        local.get 4
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.tee 1
        i32.const 1
        i32.add
        local.set 0
        local.get 1
        i32.load8_u
        local.tee 3
        i32.const 128
        i32.lt_u
        if  ;; label = @3
          local.get 2
          local.get 3
          i32.store16
          local.get 2
          i32.const 2
          i32.add
          local.set 2
        else
          local.get 3
          i32.const 224
          i32.lt_u
          i32.const 0
          local.get 3
          i32.const 191
          i32.gt_u
          select
          if  ;; label = @4
            local.get 4
            local.get 0
            i32.sub
            i32.const 1
            i32.lt_u
            br_if 2 (;@2;)
            local.get 0
            local.tee 1
            i32.const 1
            i32.add
            local.set 0
            local.get 2
            local.get 1
            i32.load8_u
            i32.const 63
            i32.and
            local.get 3
            i32.const 31
            i32.and
            i32.const 6
            i32.shl
            i32.or
            i32.store16
            local.get 2
            i32.const 2
            i32.add
            local.set 2
          else
            local.get 3
            i32.const 365
            i32.lt_u
            i32.const 0
            local.get 3
            i32.const 239
            i32.gt_u
            select
            if (result i32)  ;; label = @5
              local.get 4
              local.get 0
              i32.sub
              i32.const 3
              i32.lt_u
              br_if 3 (;@2;)
              local.get 2
              local.get 0
              i32.load8_u offset=2
              i32.const 63
              i32.and
              local.get 3
              i32.const 7
              i32.and
              i32.const 18
              i32.shl
              local.get 0
              i32.load8_u
              i32.const 63
              i32.and
              i32.const 12
              i32.shl
              i32.or
              local.get 0
              i32.load8_u offset=1
              i32.const 63
              i32.and
              i32.const 6
              i32.shl
              i32.or
              i32.or
              i32.const 65536
              i32.sub
              local.tee 1
              i32.const 10
              i32.shr_u
              i32.const 55296
              i32.add
              i32.store16
              local.get 2
              local.get 1
              i32.const 1023
              i32.and
              i32.const 56320
              i32.add
              i32.store16 offset=2
              local.get 2
              i32.const 4
              i32.add
              local.set 2
              local.get 0
              i32.const 3
              i32.add
            else
              local.get 4
              local.get 0
              i32.sub
              i32.const 2
              i32.lt_u
              br_if 3 (;@2;)
              local.get 2
              local.get 0
              i32.load8_u offset=1
              i32.const 63
              i32.and
              local.get 3
              i32.const 15
              i32.and
              i32.const 12
              i32.shl
              local.get 0
              i32.load8_u
              i32.const 63
              i32.and
              i32.const 6
              i32.shl
              i32.or
              i32.or
              i32.store16
              local.get 2
              i32.const 2
              i32.add
              local.set 2
              local.get 0
              i32.const 2
              i32.add
            end
            local.set 0
          end
        end
        br 1 (;@1;)
      end
    end
    local.get 5
    local.get 2
    local.get 5
    i32.sub
    call 22)
  (func (;33;) (type 5) (param i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.load offset=8
    i32.const 1
    i32.shl
    call 16
    local.set 1
    loop  ;; label = @1
      local.get 2
      local.get 0
      i32.load offset=8
      i32.lt_s
      if  ;; label = @2
        local.get 1
        local.get 2
        i32.const 1
        i32.shl
        local.tee 3
        local.get 0
        local.get 2
        call 13
        call 28
        local.tee 4
        i32.const 0
        call 29
        call 30
        local.get 1
        local.get 3
        i32.const 1
        i32.add
        local.get 4
        i32.const 1
        call 29
        call 30
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        br 1 (;@1;)
      end
    end
    local.get 1
    i32.load
    local.get 1
    call 31
    i32.add
    local.get 1
    i32.load offset=8
    call 32)
  (func (;34;) (type 5) (param i32) (result i32)
    (local i32 i32 i32)
    i32.const 0
    local.get 0
    call 19
    local.tee 1
    i32.const 0
    local.get 1
    i32.lt_s
    select
    local.set 2
    i32.const 2
    local.get 1
    i32.const 2
    local.get 1
    i32.lt_s
    select
    local.get 2
    i32.sub
    local.tee 1
    i32.const 0
    i32.le_s
    if  ;; label = @1
      i32.const 10064
      return
    end
    local.get 1
    i32.const 1
    i32.shl
    local.tee 1
    i32.const 1
    call 7
    local.tee 3
    local.get 2
    i32.const 1
    i32.shl
    local.get 0
    i32.add
    local.get 1
    call 21
    local.get 3)
  (func (;35;) (type 4) (param i32 i32) (result i32)
    (local i32 i32)
    i32.const 10128
    local.set 2
    loop  ;; label = @1
      local.get 1
      if (result i32)  ;; label = @2
        local.get 0
        i32.load16_u
        local.get 2
        i32.load16_u
        i32.sub
        local.tee 3
        i32.eqz
      else
        i32.const 0
      end
      if  ;; label = @2
        local.get 1
        i32.const 1
        i32.sub
        local.set 1
        local.get 0
        i32.const 2
        i32.add
        local.set 0
        local.get 2
        i32.const 2
        i32.add
        local.set 2
        br 1 (;@1;)
      end
    end
    local.get 3)
  (func (;36;) (type 5) (param i32) (result i32)
    (local i32)
    local.get 0
    i32.const 10128
    i32.eq
    if  ;; label = @1
      i32.const 1
      return
    end
    block  ;; label = @1
      i32.const 0
      i32.const 1
      local.get 0
      select
      br_if 0 (;@1;)
      local.get 0
      call 19
      local.tee 1
      i32.const 10128
      call 19
      i32.ne
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call 35
      i32.eqz
      return
    end
    i32.const 0)
  (func (;37;) (type 5) (param i32) (result i32)
    local.get 0
    i32.const 255
    i32.le_s
    if  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const 10
          i32.eq
          local.get 0
          i32.const 11
          i32.eq
          i32.or
          local.get 0
          i32.const 9
          i32.eq
          i32.or
          br_if 0 (;@3;)
          local.get 0
          i32.const 12
          i32.eq
          local.get 0
          i32.const 13
          i32.eq
          i32.or
          local.get 0
          i32.const 32
          i32.eq
          local.get 0
          i32.const 160
          i32.eq
          i32.or
          i32.or
          br_if 0 (;@3;)
          br 1 (;@2;)
        end
        i32.const 1
        return
      end
      i32.const 0
      return
    end
    local.get 0
    i32.const 8202
    i32.le_s
    i32.const 0
    local.get 0
    i32.const 8192
    i32.ge_s
    select
    if  ;; label = @1
      i32.const 1
      return
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 8232
        i32.eq
        local.get 0
        i32.const 8233
        i32.eq
        i32.or
        local.get 0
        i32.const 5760
        i32.eq
        i32.or
        br_if 0 (;@2;)
        local.get 0
        i32.const 8239
        i32.eq
        local.get 0
        i32.const 8287
        i32.eq
        i32.or
        local.get 0
        i32.const 12288
        i32.eq
        local.get 0
        i32.const 65279
        i32.eq
        i32.or
        i32.or
        br_if 0 (;@2;)
        br 1 (;@1;)
      end
      i32.const 1
      return
    end
    i32.const 0)
  (func (;38;) (type 5) (param i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      call 19
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.tee 1
      i32.load16_u
      local.set 0
      i32.const 1
      local.set 3
      loop  ;; label = @2
        local.get 0
        call 37
        if  ;; label = @3
          local.get 1
          i32.const 2
          i32.add
          local.tee 1
          i32.load16_u
          local.set 0
          local.get 2
          i32.const 1
          i32.sub
          local.set 2
          br 1 (;@2;)
        end
      end
      local.get 0
      i32.const 45
      i32.eq
      if  ;; label = @2
        local.get 2
        i32.const 1
        i32.sub
        local.tee 2
        i32.eqz
        br_if 1 (;@1;)
        i32.const -1
        local.set 3
        local.get 1
        i32.const 2
        i32.add
        local.tee 1
        i32.load16_u
        drop
      else
        local.get 0
        i32.const 43
        i32.eq
        if  ;; label = @3
          local.get 2
          i32.const 1
          i32.sub
          local.tee 2
          i32.eqz
          br_if 2 (;@1;)
          local.get 1
          i32.const 2
          i32.add
          local.tee 1
          i32.load16_u
          drop
        end
      end
      loop  ;; label = @2
        block  ;; label = @3
          local.get 2
          local.tee 0
          i32.const 1
          i32.sub
          local.set 2
          local.get 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.load16_u
          local.tee 0
          i32.const 48
          i32.ge_s
          if (result i32)  ;; label = @4
            local.get 0
            i32.const 57
            i32.le_s
          else
            i32.const 0
          end
          if (result i32)  ;; label = @4
            local.get 0
            i32.const 48
            i32.sub
          else
            local.get 0
            i32.const 90
            i32.le_s
            i32.const 0
            local.get 0
            i32.const 65
            i32.ge_s
            select
            if (result i32)  ;; label = @5
              local.get 0
              i32.const 55
              i32.sub
            else
              local.get 0
              i32.const 122
              i32.le_s
              i32.const 0
              local.get 0
              i32.const 97
              i32.ge_s
              select
              i32.eqz
              br_if 2 (;@3;)
              local.get 0
              i32.const 87
              i32.sub
            end
          end
          local.tee 0
          i32.const 16
          i32.ge_s
          br_if 0 (;@3;)
          local.get 4
          i32.const 4
          i32.shl
          local.get 0
          i32.add
          local.set 4
          local.get 1
          i32.const 2
          i32.add
          local.set 1
          br 1 (;@2;)
        end
      end
      local.get 3
      local.get 4
      i32.mul
      return
    end
    i32.const 0)
  (func (;39;) (type 5) (param i32) (result i32)
    local.get 0
    call 34
    call 36
    if  ;; label = @1
      unreachable
    end
    local.get 0
    call 38)
  (func (;40;) (type 5) (param i32) (result i32)
    (local i32 i32)
    i32.const 16
    i32.const 6
    call 7
    local.tee 1
    i32.const 0
    i32.const 0
    call 7
    local.tee 2
    i32.store
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    i32.const 0
    i32.store offset=8
    local.get 1
    i32.const 0
    i32.store offset=12
    local.get 0
    if  ;; label = @1
      local.get 2
      local.get 0
      i32.const 0
      call 21
    end
    local.get 1)
  (func (;41;) (type 5) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    i32.load offset=8
    i32.eqz
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.const 0
    call 13
    local.tee 1
    i32.const 127
    i32.le_u
    if (result i32)  ;; label = @1
      local.get 0
      i32.const 0
      i32.const 1
      call 18
      i32.const 0
      call 17
      local.get 0
      i32.const 1
      i32.const 2147483647
      call 18
      call 14
    else
      local.get 1
      i32.const 183
      i32.le_u
      if (result i32)  ;; label = @2
        local.get 1
        i32.const 127
        i32.sub
        i32.const 255
        i32.and
        local.set 2
        local.get 1
        i32.const 128
        i32.eq
        if  ;; label = @3
          i32.const 0
          call 16
          i32.const 0
          call 17
          local.get 0
          local.get 2
          i32.const 2147483647
          call 18
          call 14
          return
        end
        local.get 0
        i32.const 1
        local.get 2
        call 18
        local.set 1
        local.get 2
        i32.const 2
        i32.eq
        if (result i32)  ;; label = @3
          local.get 1
          i32.const 0
          call 13
          i32.const 128
          i32.lt_u
        else
          i32.const 0
        end
        if  ;; label = @3
          unreachable
        end
        local.get 1
        i32.const 0
        call 17
        local.get 0
        local.get 2
        i32.const 2147483647
        call 18
        call 14
      else
        local.get 1
        i32.const 191
        i32.le_u
        if (result i32)  ;; label = @3
          local.get 0
          i32.const 1
          local.get 1
          i32.const 182
          i32.sub
          local.tee 3
          i32.const 255
          i32.and
          local.tee 2
          call 18
          call 33
          call 39
          local.set 1
          local.get 0
          local.get 2
          local.get 1
          local.get 2
          i32.add
          call 18
          local.tee 2
          i32.load offset=8
          local.get 1
          i32.lt_u
          if  ;; label = @4
            unreachable
          end
          local.get 2
          i32.const 0
          call 17
          local.get 0
          local.get 3
          i32.const 255
          i32.and
          local.get 1
          i32.add
          i32.const 2147483647
          call 18
          call 14
        else
          local.get 1
          i32.const 247
          i32.le_u
          if (result i32)  ;; label = @4
            local.get 0
            i32.const 1
            local.get 1
            i32.const 191
            i32.sub
            i32.const 255
            i32.and
            local.tee 3
            call 18
            local.set 1
            i32.const 10152
            call 40
            local.set 2
            loop  ;; label = @5
              local.get 1
              i32.load offset=8
              if  ;; label = @6
                local.get 2
                local.get 1
                call 41
                local.tee 1
                i32.load
                call 24
                local.get 1
                i32.load offset=4
                local.set 1
                br 1 (;@5;)
              end
            end
            i32.const 0
            local.get 2
            call 17
            local.get 0
            local.get 3
            i32.const 2147483647
            call 18
            call 14
          else
            local.get 0
            i32.const 1
            local.get 1
            i32.const 246
            i32.sub
            local.tee 1
            i32.const 255
            i32.and
            local.tee 2
            call 18
            call 33
            local.set 3
            local.get 3
            call 39
            local.get 2
            i32.add
            local.tee 2
            local.get 0
            i32.load offset=8
            i32.gt_u
            if  ;; label = @5
              unreachable
            end
            local.get 0
            local.get 1
            i32.const 255
            i32.and
            local.get 2
            call 18
            local.tee 1
            i32.load offset=8
            i32.eqz
            if  ;; label = @5
              unreachable
            end
            i32.const 10168
            call 40
            local.set 3
            loop  ;; label = @5
              local.get 1
              i32.load offset=8
              if  ;; label = @6
                local.get 3
                local.get 1
                call 41
                local.tee 1
                i32.load
                call 24
                local.get 1
                i32.load offset=4
                local.set 1
                br 1 (;@5;)
              end
            end
            i32.const 0
            local.get 3
            call 17
            local.get 0
            local.get 2
            i32.const 2147483647
            call 18
            call 14
          end
        end
      end
    end)
  (func (;42;) (type 5) (param i32) (result i32)
    local.get 0
    call 41
    local.tee 0
    i32.load offset=4
    i32.load offset=8
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load)
  (func (;43;) (type 4) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load offset=12
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 1
    local.get 0
    i32.load offset=8
    i32.const 2
    i32.shr_u
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.const 2
    i32.shl
    i32.add
    i32.load)
  (func (;44;) (type 3) (param i32 i32 i32)
    local.get 1
    local.get 0
    i32.load offset=8
    i32.const 2
    i32.shr_u
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.const 2
    i32.shl
    i32.add
    local.get 2
    i32.store)
  (func (;45;) (type 5) (param i32) (result i32)
    (local i32)
    i32.const 16
    i32.const 11
    call 7
    local.get 0
    i32.const 0
    call 15
    local.tee 1
    i32.const 0
    i32.store offset=12
    local.get 1
    local.get 0
    i32.store offset=12
    local.get 1)
  (func (;46;) (type 3) (param i32 i32 i32)
    (local i32)
    local.get 0
    i32.load offset=12
    local.set 3
    local.get 0
    local.get 1
    i32.const 1
    i32.add
    i32.const 0
    call 23
    local.get 0
    i32.load offset=4
    local.get 1
    i32.add
    local.get 2
    i32.store8
    local.get 1
    local.get 3
    i32.ge_s
    if  ;; label = @1
      local.get 0
      local.get 1
      i32.const 1
      i32.add
      i32.store offset=12
    end)
  (func (;47;) (type 4) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load offset=8
    i32.const 2
    i32.shr_u
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.const 2
    i32.shl
    i32.add
    i32.load)
  (func (;48;) (type 3) (param i32 i32 i32)
    (local i32)
    local.get 0
    i32.load offset=12
    local.set 3
    local.get 0
    local.get 1
    i32.const 1
    i32.add
    i32.const 2
    call 23
    local.get 0
    i32.load offset=4
    local.get 1
    i32.const 2
    i32.shl
    i32.add
    local.get 2
    i32.store
    local.get 1
    local.get 3
    i32.ge_s
    if  ;; label = @1
      local.get 0
      local.get 1
      i32.const 1
      i32.add
      i32.store offset=12
    end)
  (func (;49;) (type 7) (param i32 i32) (result i64)
    local.get 1
    local.get 0
    i32.load offset=8
    i32.const 3
    i32.shr_u
    i32.ge_u
    if  ;; label = @1
      unreachable
    end
    local.get 0
    i32.load offset=4
    local.get 1
    i32.const 3
    i32.shl
    i32.add
    i64.load)
  (func (;50;) (type 2) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    i32.const 650
    call 9
    drop
    i32.const 32
    call 9
    call 11
    drop
    i32.const 32
    call 9
    local.tee 0
    call 11
    local.set 11
    local.get 0
    call 4
    call 2
    local.tee 1
    call 9
    local.tee 0
    i32.const 0
    local.get 1
    call 3
    local.get 0
    local.get 1
    call 12
    call 42
    local.tee 3
    i32.load offset=4
    i32.const 0
    call 43
    local.set 0
    local.get 3
    i32.load offset=4
    i32.const 1
    call 43
    i32.load
    local.set 1
    local.get 3
    i32.load offset=4
    i32.const 2
    call 43
    i32.load
    local.set 9
    local.get 1
    i32.load
    local.get 1
    call 31
    i32.add
    local.set 16
    local.get 0
    i32.load
    call 42
    i32.load offset=4
    local.set 17
    i32.const 12
    i32.const 10
    call 7
    i32.const 100
    i32.const 2
    call 15
    local.set 10
    loop  ;; label = @1
      local.get 4
      local.get 9
      i32.load offset=8
      i32.lt_s
      if  ;; label = @2
        local.get 9
        local.get 4
        call 13
        local.set 0
        local.get 4
        i32.const 1
        i32.add
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const 128
              i32.ne
              if  ;; label = @6
                local.get 0
                i32.const 129
                i32.eq
                br_if 1 (;@5;)
                local.get 0
                i32.const 130
                i32.eq
                br_if 2 (;@4;)
                br 3 (;@3;)
              end
              local.get 17
              local.get 12
              call 43
              i32.load
              local.set 1
              local.get 12
              i32.const 1
              i32.add
              local.set 12
              i32.const 80
              call 0
              local.get 1
              i32.load
              local.get 1
              call 31
              i32.add
              local.get 1
              i32.load offset=8
              call 1
              i32.const 32
              call 9
              local.tee 0
              local.get 1
              i32.load
              local.get 1
              call 31
              i32.add
              local.get 1
              i32.load offset=8
              call 6
              local.get 0
              i32.const 32
              call 1
              local.get 10
              local.get 5
              local.get 0
              call 44
              local.get 5
              i32.const 1
              i32.add
              local.set 5
              local.get 4
              i32.const 1
              i32.add
              local.set 4
              br 2 (;@3;)
            end
            local.get 9
            local.get 4
            call 13
            local.set 6
            local.get 4
            i32.const 1
            i32.add
            local.set 4
            i32.const 17
            local.get 6
            i32.sub
            local.get 6
            i32.const 33
            i32.mul
            i32.add
            local.set 0
            local.get 6
            i32.const 8
            i32.lt_s
            if (result i32)  ;; label = @5
              local.get 0
              i32.const 2
              i32.add
              local.tee 13
              call 9
              local.tee 7
              i32.const 248
              i32.store8
              local.get 7
              i32.const 1
              i32.add
              local.get 0
              i32.const 255
              i32.and
              i32.store16
              local.get 7
              i32.const 2
              i32.add
            else
              local.get 0
              i32.const 3
              i32.add
              local.tee 13
              call 9
              local.tee 7
              i32.const 249
              i32.store8
              local.get 7
              i32.const 1
              i32.add
              local.get 0
              i32.const 8
              i32.shl
              local.get 0
              i32.const 65535
              i32.and
              i32.const 8
              i32.shr_u
              i32.or
              i32.store16
              local.get 7
              i32.const 3
              i32.add
            end
            local.set 3
            local.get 6
            call 45
            local.set 8
            i32.const 0
            local.set 2
            loop  ;; label = @5
              local.get 2
              local.get 6
              i32.lt_s
              if  ;; label = @6
                local.get 8
                local.get 2
                local.get 9
                local.get 4
                call 13
                call 46
                local.get 4
                i32.const 1
                i32.add
                local.set 4
                local.get 2
                i32.const 1
                i32.add
                local.set 2
                br 1 (;@5;)
              end
            end
            local.get 6
            call 45
            local.set 14
            i32.const 16
            i32.const 12
            call 7
            local.get 6
            i32.const 2
            call 15
            local.tee 1
            i32.const 0
            i32.store offset=12
            local.get 1
            local.get 6
            i32.store offset=12
            i32.const 0
            local.set 2
            loop  ;; label = @5
              local.get 2
              local.get 6
              i32.lt_s
              if  ;; label = @6
                local.get 14
                local.get 2
                local.get 8
                local.get 6
                i32.const 1
                i32.sub
                local.get 2
                i32.sub
                local.tee 0
                call 13
                call 46
                local.get 1
                local.get 0
                local.get 10
                local.get 5
                i32.const 1
                i32.sub
                local.tee 5
                call 47
                call 48
                local.get 2
                i32.const 1
                i32.add
                local.set 2
                br 1 (;@5;)
              end
            end
            i32.const 0
            local.set 8
            i32.const 0
            local.set 2
            loop  ;; label = @5
              local.get 2
              i32.const 17
              i32.lt_u
              if  ;; label = @6
                local.get 8
                local.get 6
                i32.lt_s
                if  ;; label = @7
                  local.get 2
                  local.get 14
                  local.get 8
                  call 13
                  local.tee 0
                  i32.lt_u
                  if  ;; label = @8
                    local.get 3
                    i32.const 128
                    local.get 0
                    local.get 2
                    i32.sub
                    i32.const 255
                    i32.and
                    local.tee 2
                    call 8
                    local.get 2
                    local.get 3
                    i32.add
                    local.set 3
                    local.get 0
                    local.set 2
                  end
                  local.get 3
                  i32.const 160
                  i32.store8
                  local.get 3
                  i32.const 1
                  i32.add
                  local.tee 0
                  local.get 1
                  local.get 8
                  call 47
                  i32.const 32
                  call 21
                  local.get 8
                  i32.const 1
                  i32.add
                  local.set 8
                  local.get 0
                  i32.const 32
                  i32.add
                  local.set 3
                  local.get 2
                  i32.const 1
                  i32.add
                  local.set 2
                  br 2 (;@5;)
                else
                  local.get 3
                  i32.const 128
                  i32.const 17
                  local.get 2
                  i32.sub
                  call 8
                end
              end
            end
            i32.const 32
            call 9
            local.tee 0
            local.get 7
            local.get 13
            call 6
            local.get 10
            local.get 5
            local.get 0
            call 44
            local.get 5
            i32.const 1
            i32.add
            local.set 5
            br 1 (;@3;)
          end
          local.get 9
          local.get 4
          call 13
          local.set 1
          local.get 4
          i32.const 1
          i32.add
          local.set 4
          i32.const 0
          local.set 7
          loop  ;; label = @4
            local.get 7
            local.get 1
            i32.lt_s
            if  ;; label = @5
              local.get 15
              i32.const 5
              i32.shl
              local.get 16
              i32.add
              local.set 0
              local.get 15
              i32.const 1
              i32.add
              local.set 15
              local.get 10
              local.get 5
              local.get 0
              call 44
              local.get 5
              i32.const 1
              i32.add
              local.set 5
              local.get 7
              i32.const 1
              i32.add
              local.set 7
              br 1 (;@4;)
            end
          end
        end
        br 1 (;@1;)
      end
    end
    local.get 10
    local.get 5
    i32.const 1
    i32.sub
    call 47
    local.set 1
    i32.const 32
    call 9
    local.tee 0
    local.get 1
    i32.const 32
    call 21
    local.get 0
    call 11
    local.tee 3
    i32.const 0
    call 49
    local.get 11
    i32.const 0
    call 49
    i64.ne
    if (result i32)  ;; label = @1
      i32.const 1
    else
      local.get 3
      i32.const 1
      call 49
      local.get 11
      i32.const 1
      call 49
      i64.ne
    end
    if (result i32)  ;; label = @1
      i32.const 1
    else
      local.get 3
      i32.const 2
      call 49
      local.get 11
      i32.const 2
      call 49
      i64.ne
    end
    if (result i32)  ;; label = @1
      i32.const 1
    else
      local.get 3
      i32.const 3
      call 49
      local.get 11
      i32.const 3
      call 49
      i64.ne
    end
    if  ;; label = @1
      unreachable
    end
    local.get 1
    call 5
    i32.const 1)
  (func (;51;) (type 8)
    i32.const 10176
    global.set 0
    global.get 0
    global.set 1)
  (func (;52;) (type 8)
    nop)
  (memory (;0;) 1)
  (global (;0;) (mut i32) (i32.const 0))
  (global (;1;) (mut i32) (i32.const 0))
  (export "memory" (memory 0))
  (export "debug" (func 0))
  (export "debug_mem" (func 1))
  (export "eth2_blockDataSize" (func 2))
  (export "eth2_blockDataCopy" (func 3))
  (export "eth2_loadPreStateRoot" (func 4))
  (export "eth2_savePostStateRoot" (func 5))
  (export "main" (func 50))
  (start 51)
  (data (;0;) (i32.const 10000) " \00\00\00\01\00\00\00\01\00\00\00 \00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f")
  (data (;1;) (i32.const 10052) "\01\00\00\00\01")
  (data (;2;) (i32.const 10064) "\02\00\00\00\01\00\00\00\01\00\00\00\02\00\00\000")
  (data (;3;) (i32.const 10088) "\08\00\00\00\01\00\00\00\01\00\00\00\08\00\00\00n\00u\00l\00l")
  (data (;4;) (i32.const 10112) "\04\00\00\00\01\00\00\00\01\00\00\00\04\00\00\000\000")
  (data (;5;) (i32.const 10140) "\01")
  (data (;6;) (i32.const 10156) "\01"))
