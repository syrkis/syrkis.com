import { format } from "date-fns";

export function formatDate(dateString: string) {
    const match = dateString.match(
        /year:\s*(\d+),\s*month:\s*(\d+),\s*day:\s*(\d+)/,
    );
    if (!match) return dateString;

    const [_, year, month, day] = match;
    const date = new Date(Number(year), Number(month) - 1, Number(day));

    return format(date, "MMMM d, yyyy"); // Or any other format pattern
}
