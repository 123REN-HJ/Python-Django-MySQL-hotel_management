document.addEventListener('DOMContentLoaded', function() {
    const menu = document.querySelector('.menu');
    
    // 使用事件委托处理所有点击事件
    menu.addEventListener('click', function(e) {
        const target = e.target;
        
        // 检查是否点击的是子菜单中的链接
        if (target.matches('.submenu a') || target.closest('.submenu a')) {
            // 子菜单链接的点击，不做任何处理
            return;
        }
        
        // 检查是否点击的是菜单链接或其子元素
        const menuLink = target.matches('.menu-link') ? target : target.closest('.menu-link');
        if (menuLink) {
            e.preventDefault();
            e.stopPropagation();
            
            const menuItem = menuLink.parentElement;
            const submenu = menuItem.querySelector('.submenu');
            
            if (submenu) {
                // 切换当前菜单的展开状态
                const isActive = menuItem.classList.contains('active');
                
                // 设置子菜单的显示状态
                if (!isActive) {
                    menuItem.classList.add('active');
                    submenu.style.maxHeight = submenu.scrollHeight + "px";
                } else {
                    menuItem.classList.remove('active');
                    submenu.style.maxHeight = "0";
                }
            }
        }
    });
    
    // 根据当前页面URL激活对应的菜单项
    const currentPath = window.location.pathname;
    const currentLink = menu.querySelector(`a[href="${currentPath}"]`);
    
    if (currentLink) {
        // 找到当前页面对应的菜单项
        const menuItem = currentLink.closest('.menu-item');
        if (menuItem) {
            // 如果是子菜单项，展开其父菜单
            const parentMenuItem = currentLink.closest('.submenu')?.closest('.menu-item');
            if (parentMenuItem) {
                parentMenuItem.classList.add('active');
                const parentSubmenu = parentMenuItem.querySelector('.submenu');
                if (parentSubmenu) {
                    parentSubmenu.style.maxHeight = parentSubmenu.scrollHeight + "px";
                }
            }
        }
        // 添加激活样式
        currentLink.classList.add('active');
    }
}); 