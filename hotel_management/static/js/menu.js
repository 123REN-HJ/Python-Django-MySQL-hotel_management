class MenuManager {
    constructor() {
        this.init();
    }

    init() {
        // 只为菜单标题添加点击事件
        document.querySelectorAll('.menu-title').forEach(title => {
            title.onclick = (e) => {
                e.preventDefault();
                e.stopPropagation();
                
                const menuGroup = title.closest('.menu-group');
                if (menuGroup) {
                    this.toggleMenuGroup(menuGroup);
                }
            };
        });

        // 初始化菜单状态
        this.initializeMenuState();
    }

    toggleMenuGroup(menuGroup) {
        menuGroup.classList.toggle('collapsed');
        
        // 保存状态
        const titleElement = menuGroup.querySelector('.title-text');
        if (titleElement) {
            const menuId = titleElement.textContent;
            localStorage.setItem('menu_' + menuId, menuGroup.classList.contains('collapsed'));
        }
    }

    initializeMenuState() {
        document.querySelectorAll('.menu-group').forEach(group => {
            // 默认折叠
            group.classList.add('collapsed');
            
            const titleElement = group.querySelector('.title-text');
            if (titleElement) {
                const menuId = titleElement.textContent;
                const isCollapsed = localStorage.getItem('menu_' + menuId);
                
                // 恢复保存的状态
                if (isCollapsed === 'false') {
                    group.classList.remove('collapsed');
                }
                
                // 如果当前页面在某个菜单组中，展开该菜单组
                if (group.querySelector('.menu-item.active')) {
                    group.classList.remove('collapsed');
                }
            }
        });
    }
}

// 在 DOM 加载完成后初始化
document.addEventListener('DOMContentLoaded', () => {
    new MenuManager();
}); 