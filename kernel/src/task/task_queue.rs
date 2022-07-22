use alloc::{vec::Vec, collections::VecDeque};

use crate::{sync::mutex::Mutex, memory::page::get_free_page_num, task::task_scheduler::add_task_to_scheduler};


use super::exec;

lazy_static! {
    pub static ref TASK_QUEUE: Mutex<VecDeque<&'static str>> = Mutex::new(VecDeque::from(vec![
        // "runtest.exe -w entry-static.exe argv",
        // "runtest.exe -w entry-static.exe basename",
        // "runtest.exe -w entry-static.exe clocale_mbfuncs",
        // "runtest.exe -w entry-static.exe clock_gettime",
        // "runtest.exe -w entry-static.exe crypt",
        // "runtest.exe -w entry-static.exe dirname",   
        // "runtest.exe -w entry-static.exe fnmatch",    
        // "runtest.exe -w entry-static.exe iconv_open",      
        // "runtest.exe -w entry-static.exe inet_pton",
        // "runtest.exe -w entry-static.exe mbc",
        // "runtest.exe -w entry-static.exe random",
        // "runtest.exe -w entry-static.exe search_insque",
        // "runtest.exe -w entry-static.exe search_lsearch",
        // "runtest.exe -w entry-static.exe search_tsearch",
        // "runtest.exe -w entry-static.exe string",
        // "runtest.exe -w entry-static.exe string_memcpy",
        // "runtest.exe -w entry-static.exe string_memmem",
        // "runtest.exe -w entry-static.exe string_memset",
        // "runtest.exe -w entry-static.exe string_strchr",
        // "runtest.exe -w entry-static.exe string_strcspn",
        // "runtest.exe -w entry-static.exe string_strstr",
        // "runtest.exe -w entry-static.exe strtol",
        // "runtest.exe -w entry-static.exe time",
        // "runtest.exe -w entry-static.exe tls_align",
        // "runtest.exe -w entry-static.exe udiv",
        // "runtest.exe -w entry-static.exe wcsstr",
        // "runtest.exe -w entry-static.exe wcstol",
        // "runtest.exe -w entry-static.exe pleval",
        // "runtest.exe -w entry-static.exe dn_expand_empty",
        // "runtest.exe -w entry-static.exe dn_expand_ptr_0",
        // "runtest.exe -w entry-static.exe fgets_eof",
        // "runtest.exe -w entry-static.exe fgetwc_buffering",
        // "runtest.exe -w entry-static.exe fpclassify_invalid_ld80",
        // "runtest.exe -w entry-static.exe getpwnam_r_crash",
        // "runtest.exe -w entry-static.exe getpwnam_r_errno",
        // "runtest.exe -w entry-static.exe iconv_roundtrips",
        // "runtest.exe -w entry-static.exe inet_ntop_v4mapped",
        // "runtest.exe -w entry-static.exe inet_pton_empty_last_field",
        // "runtest.exe -w entry-static.exe iswspace_null",
        // "runtest.exe -w entry-static.exe lrand48_signextend",
        // "runtest.exe -w entry-static.exe malloc_0",
        // "runtest.exe -w entry-static.exe mbsrtowcs_overflow",
        // "runtest.exe -w entry-static.exe memmem_oob_read",
        // "runtest.exe -w entry-static.exe memmem_oob",
        // "runtest.exe -w entry-static.exe mkdtemp_failure",
        // "runtest.exe -w entry-static.exe mkstemp_failure",
        // "runtest.exe -w entry-static.exe printf_fmt_n",
        // "runtest.exe -w entry-static.exe regex_escaped_high_byte",
        // "runtest.exe -w entry-static.exe regexec_nosub",
        // "runtest.exe -w entry-static.exe scanf_bytes_consumed",
        // "runtest.exe -w entry-static.exe scanf_match_literal_eof",
        // "runtest.exe -w entry-static.exe scanf_nullbyte_char",
        // "runtest.exe -w entry-static.exe setvbuf_unget",
        // "runtest.exe -w entry-static.exe sigprocmask_internal",
        // "runtest.exe -w entry-static.exe strverscmp",
        // "runtest.exe -w entry-static.exe uselocale_0",
        // "runtest.exe -w entry-static.exe wcsncpy_read_overflow",
        // "runtest.exe -w entry-static.exe wcsstr_false_negative",
        // // dynamic
        // "runtest.exe -w entry-dynamic.exe argv",
        // "runtest.exe -w entry-dynamic.exe basename",
        // "runtest.exe -w entry-dynamic.exe clocale_mbfuncs",
        // "runtest.exe -w entry-dynamic.exe clock_gettime",
        // "runtest.exe -w entry-dynamic.exe crypt",
        // "runtest.exe -w entry-dynamic.exe dirname",   
        // "runtest.exe -w entry-dynamic.exe fnmatch",    
        // "runtest.exe -w entry-dynamic.exe inet_pton",
        // "runtest.exe -w entry-dynamic.exe mbc",
        // "runtest.exe -w entry-dynamic.exe random",
        // "runtest.exe -w entry-dynamic.exe search_insque",
        // "runtest.exe -w entry-dynamic.exe search_lsearch",
        // "runtest.exe -w entry-dynamic.exe search_tsearch",
        // "runtest.exe -w entry-dynamic.exe string",
        // "runtest.exe -w entry-dynamic.exe string_memcpy",
        // "runtest.exe -w entry-dynamic.exe string_memmem",
        // "runtest.exe -w entry-dynamic.exe string_memset",
        // "runtest.exe -w entry-dynamic.exe string_strchr",
        // "runtest.exe -w entry-dynamic.exe string_strcspn",
        // "runtest.exe -w entry-dynamic.exe string_strstr",
        // "runtest.exe -w entry-dynamic.exe strtol",
        // "runtest.exe -w entry-dynamic.exe time",
        // "runtest.exe -w entry-dynamic.exe udiv",
        // "runtest.exe -w entry-dynamic.exe wcsstr",
        // "runtest.exe -w entry-dynamic.exe wcstol",
        // "runtest.exe -w entry-dynamic.exe dn_expand_empty",
        // "runtest.exe -w entry-dynamic.exe dn_expand_ptr_0",
        // "runtest.exe -w entry-dynamic.exe fgets_eof",
        // "runtest.exe -w entry-dynamic.exe fgetwc_buffering",
        // "runtest.exe -w entry-dynamic.exe getpwnam_r_errno",
        // "runtest.exe -w entry-dynamic.exe iconv_roundtrips",
        // "runtest.exe -w entry-dynamic.exe inet_ntop_v4mapped",
        // "runtest.exe -w entry-dynamic.exe inet_pton_empty_last_field",
        // "runtest.exe -w entry-dynamic.exe iswspace_null",
        // "runtest.exe -w entry-dynamic.exe lrand48_signextend",
        // "runtest.exe -w entry-dynamic.exe malloc_0",
        // "runtest.exe -w entry-dynamic.exe mbsrtowcs_overflow",
        // "runtest.exe -w entry-dynamic.exe memmem_oob_read",
        // "runtest.exe -w entry-dynamic.exe memmem_oob",
        // "runtest.exe -w entry-dynamic.exe mkdtemp_failure",
        // "runtest.exe -w entry-dynamic.exe mkstemp_failure",
        // "runtest.exe -w entry-dynamic.exe printf_fmt_n",
        // "runtest.exe -w entry-dynamic.exe regex_escaped_high_byte",
        // "runtest.exe -w entry-dynamic.exe regexec_nosub",
        // "runtest.exe -w entry-dynamic.exe scanf_bytes_consumed",
        // "runtest.exe -w entry-dynamic.exe scanf_match_literal_eof",
        // "runtest.exe -w entry-dynamic.exe scanf_nullbyte_char",
        // "runtest.exe -w entry-dynamic.exe setvbuf_unget",
        // "runtest.exe -w entry-dynamic.exe sigprocmask_internal",
        // "runtest.exe -w entry-dynamic.exe strverscmp",
        // "runtest.exe -w entry-dynamic.exe uselocale_0",
        // "runtest.exe -w entry-dynamic.exe wcsncpy_read_overflow",
        // "runtest.exe -w entry-dynamic.exe wcsstr_false_negative",
        // "runtest.exe -w entry-static.exe stat",
        // "runtest.exe -w entry-dynamic.exe stat",

        // // 扩大栈可过
        // "runtest.exe -w entry-static.exe qsort",             // k210异常
        // "runtest.exe -w entry-dynamic.exe qsort",             // k210异常

        // // 申请临时内存作为虚拟文件
        // "runtest.exe -w entry-static.exe fdopen",   
        // "runtest.exe -w entry-dynamic.exe fdopen",  
        // "runtest.exe -w entry-dynamic.exe iconv_open",      
        // "runtest.exe -w entry-dynamic.exe fpclassify_invalid_ld80",
        // "runtest.exe -w entry-dynamic.exe getpwnam_r_crash",
        // "runtest.exe -w entry-static.exe flockfile_list",
        // "runtest.exe -w entry-dynamic.exe flockfile_list",


        // 待完成功能
        "runtest.exe -w entry-static.exe ungetc",                        // read异常
        // "runtest.exe -w entry-dynamic.exe ungetc",                       // 异常
        // "runtest.exe -w entry-dynamic.exe utime",             // 异常
        // "runtest.exe -w entry-static.exe utime",             // 异常
        // "runtest.exe -w entry-static.exe rewind_clear_error",            // 异常
        // "runtest.exe -w entry-dynamic.exe rewind_clear_error",            // 异常
        // "runtest.exe -w entry-static.exe putenv_doublefree",             // 异常
        // "runtest.exe -w entry-dynamic.exe putenv_doublefree",             // 异常
        // "runtest.exe -w entry-static.exe rlimit_open_files",             // 异常
        // "runtest.exe -w entry-dynamic.exe rlimit_open_files",             // 异常
        // "runtest.exe -w entry-static.exe statvfs",                       // 异常
        // "runtest.exe -w entry-dynamic.exe statvfs",                       // 异常
        // "runtest.exe -w entry-static.exe syscall_sign_extend",           // 异常
        // "runtest.exe -w entry-dynamic.exe syscall_sign_extend",           // 异常
        // "runtest.exe -w entry-dynamic.exe search_hsearch",    // 异常
        // "runtest.exe -w entry-static.exe search_hsearch",    // 异常
        // "runtest.exe -w entry-dynamic.exe setjmp",            // 异常
        // "runtest.exe -w entry-static.exe setjmp",            // 异常
        // "runtest.exe -w entry-dynamic.exe socket",            // 异常
        // "runtest.exe -w entry-static.exe socket",            // 异常
        // "runtest.exe -w entry-dynamic.exe sscanf_long",       // 异常
        // "runtest.exe -w entry-static.exe sscanf_long",       // 异常
        // "runtest.exe -w entry-dynamic.exe strftime",          // 异常
        // "runtest.exe -w entry-static.exe strftime",          // 异常
        // "runtest.exe -w entry-dynamic.exe strptime",          // 异常
        // "runtest.exe -w entry-static.exe strptime",          // 异常

        // "runtest.exe -w entry-static.exe pthread_cancel_points", // 异常
        // "runtest.exe -w entry-static.exe pthread_cancel",    // 异常
        // "runtest.exe -w entry-static.exe pthread_cond",      // 异常
        // "runtest.exe -w entry-static.exe pthread_tsd",       // 异常
        // "runtest.exe -w entry-static.exe pthread_robust_detach",         // 异常
        // "runtest.exe -w entry-static.exe pthread_cancel_sem_wait",       // 异常
        // "runtest.exe -w entry-static.exe pthread_cond_smasher",          // 异常
        // "runtest.exe -w entry-static.exe pthread_condattr_setclock",     // 异常
        // "runtest.exe -w entry-static.exe pthread_exit_cancel",           // 异常
        // "runtest.exe -w entry-static.exe pthread_once_deadlock",         // 异常
        // "runtest.exe -w entry-static.exe pthread_rwlock_ebusy",          // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_cancel_points", // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_cancel",    // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_cond",      // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_tsd",       // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_robust_detach",         // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_cancel_sem_wait",       // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_cond_smasher",          // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_condattr_setclock",     // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_exit_cancel",           // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_once_deadlock",         // 异常
        // "runtest.exe -w entry-dynamic.exe pthread_rwlock_ebusy",          // 异常

        // "runtest.exe -w entry-dynamic.exe tls_align",       // 错误
        // "runtest.exe -w entry-dynamic.exe pleval",          // 错误

        // "runtest.exe -w entry-dynamic.exe ftello_unflushed_append",    // 超出写入异常
        // "runtest.exe -w entry-static.exe ftello_unflushed_append",    // 异常
        // "runtest.exe -w entry-dynamic.exe lseek_large",           // 异常
        // "runtest.exe -w entry-static.exe lseek_large",           // 异常

        // Exception(StoreMisaligned)   k210 error
        // "runtest.exe -w entry-static.exe memstream",                     // k210异常
        // "runtest.exe -w entry-static.exe regex_backref_0",               // k210异常
        // "runtest.exe -w entry-static.exe regex_bracket_icase",           // k210异常
        // "runtest.exe -w entry-static.exe regex_ere_backref",             // k210异常
        // "runtest.exe -w entry-static.exe regex_negated_range",           // k210异常
        // "runtest.exe -w entry-dynamic.exe memstream",                    // k210异常
        // "runtest.exe -w entry-dynamic.exe regex_backref_0",               // k210异常
        // "runtest.exe -w entry-dynamic.exe regex_bracket_icase",           // k210异常
        // "runtest.exe -w entry-dynamic.exe regex_ere_backref",             // k210异常
        // "runtest.exe -w entry-dynamic.exe regex_negated_range",           // k210异常


        // "runtest.exe -w entry-static.exe env",           // 此异常 0 is not an allocated pointer 无法通过
        // "runtest.exe -w entry-static.exe fscanf",        // 异常
        // "runtest.exe -w entry-static.exe fwscanf",       // 异常
        // "runtest.exe -w entry-static.exe snprintf",          // 异常
        // "runtest.exe -w entry-static.exe sscanf",            // 异常
        // "runtest.exe -w entry-static.exe strtod",            // 异常
        // "runtest.exe -w entry-static.exe strtod_simple",     // 异常
        // "runtest.exe -w entry-static.exe strtof",            // 异常
        // "runtest.exe -w entry-static.exe strtold",           // 异常
        // "runtest.exe -w entry-static.exe swprintf",          // 异常
        // "runtest.exe -w entry-static.exe tgmath",            // 异常
        // "runtest.exe -w entry-static.exe daemon_failure",    // 异常
        // "runtest.exe -w entry-static.exe fflush_exit",       // 异常
        // "runtest.exe -w entry-static.exe printf_1e9_oob",                // 异常
        // "runtest.exe -w entry-static.exe printf_fmt_g_round",            // 异常
        // "runtest.exe -w entry-static.exe printf_fmt_g_zeros",            // 异常
        // "runtest.exe -w entry-static.exe sscanf_eof",                    // 异常
        // "runtest.exe -w entry-dynamic.exe env",           // 此异常 0 is not an allocated pointer 无法通过
        // "runtest.exe -w entry-dynamic.exe fscanf",        // 异常
        // "runtest.exe -w entry-dynamic.exe fwscanf",       // 异常
        // "runtest.exe -w entry-dynamic.exe snprintf",          // 异常
        // "runtest.exe -w entry-dynamic.exe sscanf",            // 异常
        // "runtest.exe -w entry-dynamic.exe strtod",            // 异常
        // "runtest.exe -w entry-dynamic.exe strtod_simple",     // 异常
        // "runtest.exe -w entry-dynamic.exe strtof",            // 异常
        // "runtest.exe -w entry-dynamic.exe strtold",           // 异常
        // "runtest.exe -w entry-dynamic.exe swprintf",          // 异常
        // "runtest.exe -w entry-dynamic.exe tgmath",            // 异常
        // "runtest.exe -w entry-dynamic.exe daemon_failure",    // 异常
        // "runtest.exe -w entry-dynamic.exe fflush_exit",       // 异常
        // "runtest.exe -w entry-dynamic.exe printf_1e9_oob",                // 异常
        // "runtest.exe -w entry-dynamic.exe printf_fmt_g_round",            // 异常
        // "runtest.exe -w entry-dynamic.exe printf_fmt_g_zeros",            // 异常
        // "runtest.exe -w entry-dynamic.exe sscanf_eof",                    // 异常
    ]));
}

pub fn exec_by_str(str: &str) {
    let args: Vec<&str> = str.split(" ").collect();
    // info!("执行任务: {}", str);
    if let Ok(task) = exec(args[0], args[0..].to_vec()) {
        add_task_to_scheduler(task);
    }
}

// 加载下一个任务
pub fn load_next_task() -> bool {
    if let Some(pro_name) = TASK_QUEUE.lock().pop_front() {
        debug!("剩余页表: {}", get_free_page_num());
        exec_by_str(pro_name);
        true
    } else {
        info!("剩余页表: {}", get_free_page_num());
        false
    }
}

// 注意 后面的机会 是对Task实现Syscall 
// 这样在 可以在impl 内部使用self 作为task 
// 但是需要一个task外的函数 作为调度 可以顺利抛出函数
// 使用change_task 返回函数主体， 可以让过程更加完善 更像写一个程序 而不是分离开