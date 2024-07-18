interface InputProps {
  label: string;
  value: string;
}

export default function Input({ label, value }: InputProps) {
  return (
    <div className="rounded-md bg-neutral-800 ring-1 ring-black px-3 py-2 shadow-sm focus-within:ring-1 focus-within:ring-sky-500">
      <label className="block text-sky-500 text-xs font-medium">{label}</label>
      <input
        type="text"
        className="block text-white text-bold font-normal bg-neutral-800 w-full border-0 p-0 focus:ring-0 text-xs"
        value={value}
      />
    </div>
  );
}
