function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

function updateReservationStatus(reservationId, action) {
    const csrftoken = getCookie('csrftoken');
    
    fetch(`/reservations/reservation/${reservationId}/${action}/`, {
        method: 'POST',
        headers: {
            'X-CSRFToken': csrftoken,
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 刷新页面显示更新后的状态
            window.location.reload();
        } else {
            alert(data.error || '操作失败');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('操作失败');
    });
}

function confirmReservation(reservationId) {
    if (confirm('确认要确认这个预订吗？')) {
        updateReservationStatus(reservationId, 'confirm');
    }
}

function checkInReservation(reservationId) {
    if (confirm('确认要为这个预订办理入住吗？')) {
        updateReservationStatus(reservationId, 'check-in');
    }
}

function checkOutReservation(reservationId) {
    if (confirm('确认要为这个预订办理退房吗？')) {
        updateReservationStatus(reservationId, 'check-out');
    }
}

function cancelReservation(reservationId) {
    if (confirm('确认要取消这个预订吗？')) {
        updateReservationStatus(reservationId, 'cancel');
    }
} 