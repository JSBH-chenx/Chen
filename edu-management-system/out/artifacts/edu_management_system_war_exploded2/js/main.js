// 主JavaScript文件

// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    // 初始化工具提示
    initTooltips();

    // 初始化表单验证
    initFormValidation();

    // 初始化确认对话框
    initConfirmDialogs();
});

// 初始化工具提示
function initTooltips() {
    const tooltips = document.querySelectorAll('[data-tooltip]');
    tooltips.forEach(element => {
        element.addEventListener('mouseenter', showTooltip);
        element.addEventListener('mouseleave', hideTooltip);
    });
}

function showTooltip(e) {
    const tooltipText = e.target.getAttribute('data-tooltip');
    if (!tooltipText) return;

    const tooltip = document.createElement('div');
    tooltip.className = 'tooltip';
    tooltip.textContent = tooltipText;
    tooltip.style.position = 'absolute';
    tooltip.style.background = '#333';
    tooltip.style.color = 'white';
    tooltip.style.padding = '8px 12px';
    tooltip.style.borderRadius = '4px';
    tooltip.style.fontSize = '12px';
    tooltip.style.zIndex = '1000';
    tooltip.style.whiteSpace = 'nowrap';

    document.body.appendChild(tooltip);

    const rect = e.target.getBoundingClientRect();
    tooltip.style.left = rect.left + 'px';
    tooltip.style.top = (rect.top - tooltip.offsetHeight - 5) + 'px';

    e.target._tooltip = tooltip;
}

function hideTooltip(e) {
    if (e.target._tooltip) {
        e.target._tooltip.remove();
        delete e.target._tooltip;
    }
}

// 初始化表单验证
function initFormValidation() {
    const forms = document.querySelectorAll('form[data-validate]');
    forms.forEach(form => {
        form.addEventListener('submit', validateForm);
    });
}

function validateForm(e) {
    const form = e.target;
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            isValid = false;
            showInputError(input, '此字段不能为空');
        } else {
            clearInputError(input);
        }
    });

    if (!isValid) {
        e.preventDefault();
        alert('请填写所有必填字段！');
    }
}

function showInputError(input, message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'input-error';
    errorDiv.textContent = message;
    errorDiv.style.color = '#ef4444';
    errorDiv.style.fontSize = '12px';
    errorDiv.style.marginTop = '5px';

    input.parentNode.appendChild(errorDiv);
    input.style.borderColor = '#ef4444';
}

function clearInputError(input) {
    const errorDiv = input.parentNode.querySelector('.input-error');
    if (errorDiv) {
        errorDiv.remove();
    }
    input.style.borderColor = '';
}

// 初始化确认对话框
function initConfirmDialogs() {
    const confirmLinks = document.querySelectorAll('a[data-confirm]');
    confirmLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const message = this.getAttribute('data-confirm') || '确定要执行此操作吗？';
            if (!confirm(message)) {
                e.preventDefault();
            }
        });
    });
}

// AJAX请求辅助函数
function makeRequest(url, method, data, callback) {
    const xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                callback(null, JSON.parse(xhr.responseText));
            } else {
                callback(new Error('请求失败'), null);
            }
        }
    };
    xhr.send(data);
}

// 显示消息
function showMessage(type, message, duration = 3000) {
    const messageDiv = document.createElement('div');
    messageDiv.className = `message message-${type}`;
    messageDiv.textContent = message;
    messageDiv.style.position = 'fixed';
    messageDiv.style.top = '20px';
    messageDiv.style.right = '20px';
    messageDiv.style.padding = '15px 20px';
    messageDiv.style.borderRadius = '6px';
    messageDiv.style.color = 'white';
    messageDiv.style.zIndex = '9999';
    messageDiv.style.opacity = '0';
    messageDiv.style.transition = 'opacity 0.3s';

    if (type === 'success') {
        messageDiv.style.background = '#10b981';
    } else if (type === 'error') {
        messageDiv.style.background = '#ef4444';
    } else if (type === 'info') {
        messageDiv.style.background = '#3b82f6';
    }

    document.body.appendChild(messageDiv);

    // 淡入
    setTimeout(() => {
        messageDiv.style.opacity = '1';
    }, 10);

    // 自动消失
    setTimeout(() => {
        messageDiv.style.opacity = '0';
        setTimeout(() => {
            messageDiv.remove();
        }, 300);
    }, duration);
}

// 加载动画
function showLoading() {
    let loadingDiv = document.querySelector('.loading-overlay');
    if (!loadingDiv) {
        loadingDiv = document.createElement('div');
        loadingDiv.className = 'loading-overlay';
        loadingDiv.innerHTML = '<div class="loading-spinner"></div>';
        loadingDiv.style.position = 'fixed';
        loadingDiv.style.top = '0';
        loadingDiv.style.left = '0';
        loadingDiv.style.width = '100%';
        loadingDiv.style.height = '100%';
        loadingDiv.style.background = 'rgba(255, 255, 255, 0.8)';
        loadingDiv.style.display = 'flex';
        loadingDiv.style.alignItems = 'center';
        loadingDiv.style.justifyContent = 'center';
        loadingDiv.style.zIndex = '9998';

        const spinner = loadingDiv.querySelector('.loading-spinner');
        spinner.style.width = '40px';
        spinner.style.height = '40px';
        spinner.style.border = '4px solid #f3f3f3';
        spinner.style.borderTop = '4px solid #667eea';
        spinner.style.borderRadius = '50%';
        spinner.style.animation = 'spin 1s linear infinite';

        const style = document.createElement('style');
        style.textContent = `
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);

        document.body.appendChild(loadingDiv);
    }
}

function hideLoading() {
    const loadingDiv = document.querySelector('.loading-overlay');
    if (loadingDiv) {
        loadingDiv.remove();
    }
}

// 导出函数供全局使用
window.showMessage = showMessage;
window.showLoading = showLoading;
window.hideLoading = hideLoading;