pub const AT_NULL: usize = 0;
pub const AT_IGNORE: usize = 1;
pub const AT_EXECFD: usize = 2;
pub const AT_PHDR: usize = 3;
pub const AT_PHENT: usize = 4;
pub const AT_PHNUM: usize = 5;
pub const AT_PAGESZ: usize = 6;
pub const AT_BASE: usize = 7;
pub const AT_FLAGS: usize = 8;
pub const AT_ENTRY: usize = 9;
pub const AT_NOTELF: usize = 10;
pub const AT_UID: usize = 11;
pub const AT_EUID: usize = 12;
pub const AT_GID: usize = 13;
pub const AT_EGID: usize = 14;
pub const AT_PLATFORM: usize = 15;
pub const AT_HWCAP: usize = 16;
pub const AT_CLKTCK: usize = 17;
pub const AT_FPUCW: usize = 18;
pub const AT_DCACHEBSIZE: usize = 19;
pub const AT_ICACHEBSIZE: usize = 20;
pub const AT_UCACHEBSIZE: usize = 21;
pub const AT_IGNOREPPC: usize = 22;
pub const AT_SECURE: usize = 23;
pub const AT_BASE_PLATFORM: usize = 24;
pub const AT_RANDOM: usize = 25;
pub const AT_HWCAP2: usize = 26;

pub const AT_EXECFN: usize = 31;
pub const AT_SYSINFO: usize = 32;
pub const AT_SYSINFO_EHDR: usize = 33;

use xmas_elf::{ElfFile, program::Type};

use crate::{memory::addr::{PAGE_SIZE, get_pages_num}, runtime_err::RuntimeError};

pub trait ElfExtra {
    fn get_data_size(&self) -> usize;
    fn get_ph_addr(&self) -> Result<u64, RuntimeError>;
}

impl ElfExtra for ElfFile<'_> {
    // 获取elf加载需要的内存大小
    fn get_data_size(&self) -> usize {
        self.program_iter()
            .filter(|ph| ph.get_type().unwrap() == Type::Load)
            .map(|ph| get_pages_num((ph.virtual_addr() + ph.mem_size()) as usize))
            .max()
            .unwrap_or(0)
            * PAGE_SIZE
    }

    fn get_ph_addr(&self) -> Result<u64, RuntimeError> {
        if let Some(phdr) = self.program_iter()
            .find(|ph| ph.get_type() == Ok(Type::Phdr))
        {
            // if phdr exists in program header, use it
            Ok(phdr.virtual_addr())
        } else if let Some(elf_addr) = self
            .program_iter()
            .find(|ph| ph.get_type() == Ok(Type::Load) && ph.offset() == 0)
        {
            // otherwise, check if elf is loaded from the beginning, then phdr can be inferred.
            Ok(elf_addr.virtual_addr() + self.header.pt2.ph_offset())
        } else {
            warn!("elf: no phdr found, tls might not work");
            Err(RuntimeError::NoMatchedAddr)
        }
    }
}