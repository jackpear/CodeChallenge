const gaps = document.querySelectorAll(".work-gap");
gaps.forEach(gap => {
    gap.addEventListener('click', (e) => {
        const start = gap.getAttribute("data-start");
        const end = gap.getAttribute("data-end");
        alert(`Time available between ${start} - ${end}`);
    });
});


// const timeSlots = document.querySelectorAll('.time-slot');
// const popup = document.getElementById('popup');

// timeSlots.forEach(slot => {
//     slot.addEventListener('click', (e) => {
//         const currentTime = slot.dataset.time;
//         const column = slot.closest('.technician-column');
//         const workOrders = column.querySelectorAll('.work-order');
//         let previousEnd = null;
//         let nextStart = null;

//         workOrders.forEach(order => {
//             const start = order.dataset.start;
//             const end = order.dataset.end;
//             if (currentTime >= end) {
//                 previousEnd = end;
//             } else if (!nextStart && currentTime < start) {
//                 nextStart = start;-*
//             }
//         });

//         if (previousEnd && nextStart) {
//             popup.innerText = `Available time: from ${previousEnd} to ${nextStart}`;
//         } else if (previousEnd) {
//             popup.innerText = `Available time: from ${previousEnd} to end of day`;
//         } else if (nextStart) {
//             popup.innerText = `Available time: from start of day to ${nextStart}`;
//         } else {
//             popup.innerText = `Available time: entire day`;
//         }

//         popup.style.top = `${e.clientY}px`;
//         popup.style.left = `${e.clientX}px`;
//         popup.style.display = 'block';
//     });
// });

document.addEventListener('click', (e) => {
    console.log("CLICK!")
});